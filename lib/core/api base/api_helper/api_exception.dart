import 'package:dio/dio.dart';

abstract class AppException implements Exception {
  final String title;
  final String message;
  final String? code;

  AppException({required this.title, required this.message, this.code});

  @override
  String toString() => message;

  static AppException fromObject(Object error) {
    if (error is AppException) return error;

    if (error is DioException) {
      final statusCode = error.response?.statusCode;
      final errorData = error.response?.data;
      String message = "An unexpected error occurred.";

      if (errorData is Map<String, dynamic>) {
        message = errorData['message'] ?? errorData['error'] ?? message;
      } else if (error.message != null) {
        message = error.message!;
      }

      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return NetworkTimeoutException(
            message:
                "The connection timed out. Please check your internet connection.",
          );
        case DioExceptionType.badResponse:
          if (statusCode != null) {
            if (statusCode >= 500) {
              return ServerErrorException(
                message:
                    "Our servers are currently experiencing issues. Please try again later. ($statusCode)",
                code: statusCode.toString(),
              );
            } else if (statusCode >= 400) {
              return ApiFailureException(
                message: message,
                code: statusCode.toString(),
              );
            }
          }
          break;
        case DioExceptionType.connectionError:
          return NetworkTimeoutException(
            message:
                "No internet connection detected. Please verify your connection and try again.",
          );
        case DioExceptionType.cancel:
          return ApiFailureException(message: "The request was cancelled.");
        default:
          return UnknownException(message: message);
      }
    }

    // Default fallback for generic exceptions
    final errorStr = error.toString();
    if (errorStr.contains("TimeoutException") ||
        errorStr.contains("SocketException")) {
      return NetworkTimeoutException(
        message:
            "Network request timed out. Please check your network stability.",
      );
    }

    return UnknownException(
      message: errorStr.startsWith("Exception: ")
          ? errorStr.substring(11)
          : errorStr,
    );
  }
}

class NetworkTimeoutException extends AppException {
  NetworkTimeoutException({required super.message, super.code})
    : super(title: "Connection Timeout");
}

class ServerErrorException extends AppException {
  ServerErrorException({required super.message, super.code})
    : super(title: "Server Error");
}

class ApiFailureException extends AppException {
  ApiFailureException({required super.message, super.code})
    : super(title: "API Error");
}

class UnknownException extends AppException {
  UnknownException({required super.message, super.code})
    : super(title: "Something Went Wrong");
}
