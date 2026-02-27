// Support Tickets List Response
import 'dart:ui';

class SupportTicketsResponse {
  final String status;
  final SupportTicketsData data;

  SupportTicketsResponse({
    required this.status,
    required this.data,
  });

  factory SupportTicketsResponse.fromJson(Map<String, dynamic> json) {
    return SupportTicketsResponse(
      status: json['status'] ?? '',
      data: SupportTicketsData.fromJson(json['data']),
    );
  }

  bool get isSuccess => status.toLowerCase() == 'success';
}

class SupportTicketsData {
  final int currentPage;
  final List<SupportTicket> tickets;
  final int lastPage;
  final int perPage;
  final int total;
  final String? nextPageUrl;
  final String? prevPageUrl;

  SupportTicketsData({
    required this.currentPage,
    required this.tickets,
    required this.lastPage,
    required this.perPage,
    required this.total,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  factory SupportTicketsData.fromJson(Map<String, dynamic> json) {
    return SupportTicketsData(
      currentPage: json['current_page'] ?? 1,
      tickets: (json['data'] as List<dynamic>?)
              ?.map((e) => SupportTicket.fromJson(e))
              .toList() ??
          [],
      lastPage: json['last_page'] ?? 1,
      perPage: json['per_page'] ?? 15,
      total: json['total'] ?? 0,
      nextPageUrl: json['next_page_url']?.toString(),
      prevPageUrl: json['prev_page_url']?.toString(),
    );
  }

  bool get hasMorePages => nextPageUrl != null;
}

// Support Ticket Model
class SupportTicket {
  final String id;
  final String userId;
  final String category;
  final String priority;
  final String subject;
  final String message;
  final String? file;
  final String status;
  final String createdAt;
  final String updatedAt;

  SupportTicket({
    required this.id,
    required this.userId,
    required this.category,
    required this.priority,
    required this.subject,
    required this.message,
    this.file,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SupportTicket.fromJson(Map<String, dynamic> json) {
    return SupportTicket(
      id: json['id']?.toString() ?? '',
      userId: json['user_id']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      priority: json['priority']?.toString() ?? '',
      subject: json['subject']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      file: json['file']?.toString(),
      status: json['status']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
    );
  }

  // Helper getters for UI
  Color get statusColor {
    switch (status.toLowerCase()) {
      case 'pending':
        return const Color(0xffFFA500);
      case 'in_progress':
      case 'in progress':
        return const Color(0xff2196F3);
      case 'resolved':
      case 'closed':
        return const Color(0xff24985B);
      default:
        return const Color(0xff6B7280);
    }
  }

  Color get statusBackgroundColor {
    switch (status.toLowerCase()) {
      case 'pending':
        return const Color(0xffFFFAEB);
      case 'in_progress':
      case 'in progress':
        return const Color(0xffE3F2FD);
      case 'resolved':
      case 'closed':
        return const Color(0xffE9F5EF);
      default:
        return const Color(0xffF3F4F6);
    }
  }

  Color get priorityColor {
    switch (priority.toLowerCase()) {
      case 'high':
        return const Color(0xffDC2626);
      case 'medium':
        return const Color(0xffFFA500);
      case 'low':
        return const Color(0xff24985B);
      default:
        return const Color(0xff6B7280);
    }
  }

  String get displayStatus {
    return status.replaceAll('_', ' ').toUpperCase();
  }

  String get displayPriority {
    return priority.toUpperCase();
  }
}

// Create Ticket Response
class CreateTicketResponse {
  final String status;
  final String message;
  final SupportTicket? data;

  CreateTicketResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory CreateTicketResponse.fromJson(Map<String, dynamic> json) {
    return CreateTicketResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null ? SupportTicket.fromJson(json['data']) : null,
    );
  }

  bool get isSuccess => status.toLowerCase() == 'success';
}

// Ticket Reply Model
// class TicketReply {
//   final String id;
//   final String supportId;
//   final String userId;
//   final String message;
//   final String createdAt;
//   final String updatedAt;
//   final TicketReplyUser? user;
//   final TicketReplyStaff? staff;

//   TicketReply({
//     required this.id,
//     required this.supportId,
//     required this.userId,
//     required this.message,
//     required this.createdAt,
//     required this.updatedAt,
//     this.user,
//     this.staff,
//   });

//   factory TicketReply.fromJson(Map<String, dynamic> json) {
//     return TicketReply(
//       id: json['id']?.toString() ?? '',
//       supportId: json['support_id']?.toString() ?? '',
//       userId: json['user_id']?.toString() ?? '',
//       message: json['message']?.toString() ?? '',
//       createdAt: json['created_at']?.toString() ?? '',
//       updatedAt: json['updated_at']?.toString() ?? '',
//       user: json['user'] != null ? TicketReplyUser.fromJson(json['user']) : null,
//       staff: json['staff'] != null ? TicketReplyStaff.fromJson(json['staff']) : null,
//     );
//   }

//   bool get isFromUser => user != null;
//   bool get isFromStaff => staff != null;

//   String get senderName {
//     if (isFromUser) {
//       return user!.fullName;
//     } else if (isFromStaff) {
//       return staff!.name ?? 'Support Staff';
//     }
//     return 'Unknown';
//   }
// }

class TicketReplyUser {
  final String id;
  final String email;
  final String firstname;
  final String? middleName;
  final String surname;

  TicketReplyUser({
    required this.id,
    required this.email,
    required this.firstname,
    this.middleName,
    required this.surname,
  });

  factory TicketReplyUser.fromJson(Map<String, dynamic> json) {
    return TicketReplyUser(
      id: json['id']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      firstname: json['firstname']?.toString() ?? '',
      middleName: json['middle_name']?.toString(),
      surname: json['surname']?.toString() ?? '',
    );
  }

  String get fullName => '$firstname ${middleName ?? ''} $surname'.trim();
}

class TicketReplyStaff {
  final String? id;
  final String? name;
  final String? email;

  TicketReplyStaff({
    this.id,
    this.name,
    this.email,
  });

  factory TicketReplyStaff.fromJson(Map<String, dynamic> json) {
    return TicketReplyStaff(
      id: json['id']?.toString(),
      name: json['name']?.toString(),
      email: json['email']?.toString(),
    );
  }
}

// Reply Ticket Response
class ReplyTicketResponse {
  final String status;
  final String message;
  final TicketReply? data;

  ReplyTicketResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory ReplyTicketResponse.fromJson(Map<String, dynamic> json) {
    return ReplyTicketResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null ? TicketReply.fromJson(json['data']) : null,
    );
  }

  bool get isSuccess => status.toLowerCase() == 'success';
}

// Ticket Details Response (Show Ticket with replies)
class TicketDetailsResponse {
  final String status;
  final TicketDetailsData data;

  TicketDetailsResponse({
    required this.status,
    required this.data,
  });

  factory TicketDetailsResponse.fromJson(Map<String, dynamic> json) {
    return TicketDetailsResponse(
      status: json['status'] ?? '',
      data: TicketDetailsData.fromJson(json['data']),
    );
  }

  bool get isSuccess => status.toLowerCase() == 'success';
}

class TicketDetailsData {
  final int currentPage;
  final List<TicketReply> replies;
  final int lastPage;
  final int perPage;
  final int total;
  final String? nextPageUrl;
  final String? prevPageUrl;

  TicketDetailsData({
    required this.currentPage,
    required this.replies,
    required this.lastPage,
    required this.perPage,
    required this.total,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  factory TicketDetailsData.fromJson(Map<String, dynamic> json) {
    return TicketDetailsData(
      currentPage: json['current_page'] ?? 1,
      replies: (json['data'] as List<dynamic>?)
              ?.map((e) => TicketReply.fromJson(e))
              .toList() ??
          [],
      lastPage: json['last_page'] ?? 1,
      perPage: json['per_page'] ?? 15,
      total: json['total'] ?? 0,
      nextPageUrl: json['next_page_url']?.toString(),
      prevPageUrl: json['prev_page_url']?.toString(),
    );
  }

  bool get hasMorePages => nextPageUrl != null;
}

// Single Ticket Details Response (with replies included)
class SingleTicketResponse {
  final String status;
  final SingleTicketData data;

  SingleTicketResponse({
    required this.status,
    required this.data,
  });

  factory SingleTicketResponse.fromJson(Map<String, dynamic> json) {
    return SingleTicketResponse(
      status: json['status'] ?? '',
      data: SingleTicketData.fromJson(json['data']),
    );
  }

  bool get isSuccess => status.toLowerCase() == 'success';
}

class SingleTicketData {
  final String id;
  final String userId;
  final String category;
  final String priority;
  final String subject;
  final String message;
  final String? file;
  final String status;
  final String createdAt;
  final String updatedAt;
  final List<TicketReply> replies;

  SingleTicketData({
    required this.id,
    required this.userId,
    required this.category,
    required this.priority,
    required this.subject,
    required this.message,
    this.file,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.replies,
  });

  factory SingleTicketData.fromJson(Map<String, dynamic> json) {
    return SingleTicketData(
      id: json['id']?.toString() ?? '',
      userId: json['user_id']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      priority: json['priority']?.toString() ?? '',
      subject: json['subject']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      file: json['file']?.toString(),
      status: json['status']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
      replies: (json['replies'] as List<dynamic>?)
              ?.map((e) => TicketReply.fromJson(e))
              .toList() ??
          [],
    );
  }

  // Helper getters (same as SupportTicket)
  Color get statusColor {
    switch (status.toLowerCase()) {
      case 'pending':
        return const Color(0xffFFA500);
      case 'in_progress':
      case 'in progress':
        return const Color(0xff2196F3);
      case 'resolved':
      case 'closed':
        return const Color(0xff24985B);
      case 'replied':
        return const Color(0xff9C27B0); // Purple for replied
      default:
        return const Color(0xff6B7280);
    }
  }

  Color get statusBackgroundColor {
    switch (status.toLowerCase()) {
      case 'pending':
        return const Color(0xffFFFAEB);
      case 'in_progress':
      case 'in progress':
        return const Color(0xffE3F2FD);
      case 'resolved':
      case 'closed':
        return const Color(0xffE9F5EF);
      case 'replied':
        return const Color(0xffF3E5F5);
      default:
        return const Color(0xffF3F4F6);
    }
  }

  Color get priorityColor {
    switch (priority.toLowerCase()) {
      case 'high':
        return const Color(0xffDC2626);
      case 'medium':
        return const Color(0xffFFA500);
      case 'low':
        return const Color(0xff24985B);
      default:
        return const Color(0xff6B7280);
    }
  }

  String get displayStatus {
    return status.replaceAll('_', ' ').toUpperCase();
  }

  String get displayPriority {
    return priority.toUpperCase();
  }
}

// Update TicketReply model to handle staff_id
class TicketReply {
  final String id;
  final String supportId;
  final String userId;
  final String? staffId; // ADD THIS
  final String message;
  final String createdAt;
  final String updatedAt;
  final TicketReplyUser? user;
  final TicketReplyStaff? staff;

  TicketReply({
    required this.id,
    required this.supportId,
    required this.userId,
    this.staffId, // ADD THIS
    required this.message,
    required this.createdAt,
    required this.updatedAt,
    this.user,
    this.staff,
  });

  factory TicketReply.fromJson(Map<String, dynamic> json) {
    return TicketReply(
      id: json['id']?.toString() ?? '',
      supportId: json['support_id']?.toString() ?? '',
      userId: json['user_id']?.toString() ?? '',
      staffId: json['staff_id']?.toString(), // ADD THIS
      message: json['message']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
      user: json['user'] != null ? TicketReplyUser.fromJson(json['user']) : null,
      staff: json['staff'] != null ? TicketReplyStaff.fromJson(json['staff']) : null,
    );
  }

  bool get isFromUser => staffId == null && user != null;
  bool get isFromStaff => staffId != null && staff != null;

  String get senderName {
    if (isFromStaff && staff != null) {
      return staff!.name ?? 'Support Staff';
    } else if (isFromUser && user != null) {
      return user!.fullName;
    }
    return 'Unknown';
  }
}