import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/support_ticket_models.dart';

abstract class SupportRemoteDataSource {
  Future<SupportTicketsResponse> getAllTickets({int page = 1});
  Future<CreateTicketResponse> createTicket({
    required String subject,
    required String category,
    required String priority,
    required String message,
    File? file,
  });
  Future<SingleTicketResponse> getTicketDetails({
    required String ticketId,
    int page = 1,
  });
  Future<ReplyTicketResponse> replyToTicket({
    required String ticketId,
    required String message,
  });
}

class SupportRemoteDataSourceImpl implements SupportRemoteDataSource {
  final ApiService apiService;

  final String baseUrlExt = "/api/v1";

  SupportRemoteDataSourceImpl({required this.apiService});

  @override
  Future<SupportTicketsResponse> getAllTickets({int page = 1}) async {
    try {
      print('🎫 Fetching all tickets (page: $page)...');

      final response = await apiService.get(
        '$baseUrlExt/econsular/support-tickets',
        queryParameters: {'page': page},
      );

      print('Tickets response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final ticketsResponse = SupportTicketsResponse.fromJson(response.data);

        if (ticketsResponse.isSuccess) {
          print('✅ Loaded ${ticketsResponse.data.tickets.length} tickets');
          return ticketsResponse;
        } else {
          throw ServerException(message: 'Failed to load tickets');
        }
      } else {
        throw ServerException(
          message: response.data['message'] ?? 'Failed to load tickets',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<CreateTicketResponse> createTicket({
    required String subject,
    required String category,
    required String priority,
    required String message,
    File? file,
  }) async {
    try {
      print('📝 Creating support ticket...');

      dynamic requestData;

      if (file != null) {
        // Multipart request with file
        String fileName = file.path.split('/').last;
        
        requestData = FormData.fromMap({
          'subject': subject,
          'category': category,
          'priority': priority,
          'message': message,
          'file': await MultipartFile.fromFile(
            file.path,
            filename: fileName,
            contentType: MediaType('application', 'octet-stream'),
          ),
        });
      } else {
        // JSON request without file
        requestData = {
          'subject': subject,
          'category': category,
          'priority': priority,
          'message': message,
          'file': null,
        };
      }

      final response = await apiService.post(
        '$baseUrlExt/econsular/support-tickets',
        data: requestData,
      );

      print('Create ticket response status: ${response.statusCode}');

      if (response.statusCode != null &&
    response.statusCode! >= 200 &&
    response.statusCode! < 300) {
        final createResponse = CreateTicketResponse.fromJson(response.data);

        if (createResponse.isSuccess) {
          print('✅ Ticket created successfully');
          return createResponse;
        } else {
          throw ServerException(message: createResponse.message);
        }
      } else {
        throw ServerException(
          message: response.data['message'] ?? 'Failed to create ticket',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<SingleTicketResponse> getTicketDetails({
    required String ticketId,
    int page = 1,
  }) async {
    try {
      print('🔍 Fetching ticket details: $ticketId (page: $page)...');

      final response = await apiService.get(
        '$baseUrlExt/econsular/support-tickets/$ticketId',
        queryParameters: {
          'page': page,
        },
      );

      print('Ticket details response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final detailsResponse = SingleTicketResponse.fromJson(response.data);

        if (detailsResponse.isSuccess) {
          print('✅ Loaded ${detailsResponse.data.replies.length} replies');
          return detailsResponse;
        } else {
          throw ServerException(message: 'Failed to load ticket details');
        }
      } else {
        throw ServerException(
          message: response.data['message'] ?? 'Failed to load ticket details',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<ReplyTicketResponse> replyToTicket({
    required String ticketId,
    required String message,
  }) async {
    try {
      print('💬 Replying to ticket: $ticketId...');

      final response = await apiService.post(
        '$baseUrlExt/econsular/support-tickets/$ticketId/reply',
        data: {
          'message': message,
        },
      );

      print('Reply ticket response status: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final replyResponse = ReplyTicketResponse.fromJson(response.data);

        if (replyResponse.isSuccess) {
          print('✅ Reply added successfully');
          return replyResponse;
        } else {
          throw ServerException(message: replyResponse.message);
        }
      } else {
        throw ServerException(
          message: response.data['message'] ?? 'Failed to add reply',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException e) {
    if (e.response?.statusCode == 404) {
      return ServerException(message: 'Ticket not found');
    } else if (e.response?.statusCode == 422) {
      final errors = e.response?.data['errors'];
      if (errors != null && errors is Map) {
        final firstError = errors.values.first;
        if (firstError is List && firstError.isNotEmpty) {
          return ServerException(message: firstError.first.toString());
        }
      }
      return ServerException(message: 'Validation error');
    } else if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return NetworkException(message: 'Connection timeout. Please try again.');
    } else if (e.type == DioExceptionType.unknown) {
      return NetworkException(message: 'No internet connection');
    } else {
      return ServerException(
        message: e.response?.data['message'] ?? 'Server error occurred',
      );
    }
  }
}