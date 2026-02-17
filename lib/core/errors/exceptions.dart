// Custom exceptions for when API calls fail
class ServerException implements Exception {
  final String message;
  
  ServerException({required this.message});
  
  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;
  
  NetworkException({this.message = 'No internet connection'});
  
  @override
  String toString() => message;
}