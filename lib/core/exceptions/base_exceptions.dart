abstract class AppException implements Exception {
  final String message;

  const AppException(this.message);
}

class UnknownException extends AppException {
  UnknownException([super.message = 'Unknown exception']);
}
