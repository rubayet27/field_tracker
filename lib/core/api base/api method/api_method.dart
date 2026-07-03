import 'package:dio/dio.dart';

import '../api_helper/api_exception.dart';

class ApiMethod {
  final Dio dio;
  ApiMethod(this.dio);

  /// Common request handler
  Future<T> _request<T>({
    required Future<Response> Function() request,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final response = await request();
      final statusCode = response.statusCode ?? 0;
      if (statusCode < 200 || statusCode >= 300) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }

      final data = response.data;
      if (data == null) {
        throw ApiFailureException(message: "Response data is null");
      }
      if (data is Map<String, dynamic>) {
        if (data.containsKey('success') && data['success'] == false) {
          throw ApiFailureException(
            message: data['message'] ?? "Request failed",
          );
        }
      }
      return fromJson(data);
    } catch (e) {
      throw AppException.fromObject(e);
    }
  }

  /// GET
  Future<T> get<T>({
    required String path,
    Map<String, dynamic>? queryParams,
    required T Function(Map<String, dynamic>) fromJson,
    Options? options,
  }) {
    return _request(
      request: () =>
          dio.get(path, queryParameters: queryParams, options: options),
      fromJson: fromJson,
    );
  }

  /// POST
  Future<T> post<T>({
    required String path,
    Map<String, dynamic>? inputBody,
    Map<String, dynamic>? queryParams,
    required T Function(Map<String, dynamic>) fromJson,
    Options? options,
  }) {
    return _request(
      request: () => dio.post(
        path,
        data: inputBody,
        queryParameters: queryParams,
        options: options,
      ),
      fromJson: fromJson,
    );
  }

  /// PUT
  Future<T> put<T>({
    required String path,
    Map<String, dynamic>? inputBody,
    Map<String, dynamic>? queryParams,
    required T Function(Map<String, dynamic>) fromJson,
    Options? options,
  }) {
    return _request(
      request: () => dio.put(
        path,
        data: inputBody,
        queryParameters: queryParams,
        options: options,
      ),
      fromJson: fromJson,
    );
  }

  Future<T> patch<T>({
    required String path,
    Map<String, dynamic>? inputBody,
    Map<String, dynamic>? queryParams,
    required T Function(Map<String, dynamic>) fromJson,
    Options? options,
  }) {
    return _request(
      request: () => dio.patch(
        path,
        data: inputBody,
        queryParameters: queryParams,
        options: options,
      ),
      fromJson: fromJson,
    );
  }

  /// DELETE
  Future<T> delete<T>({
    required String path,
    Map<String, dynamic>? inputBody,
    Map<String, dynamic>? queryParams,
    required T Function(Map<String, dynamic>) fromJson,
    Options? options,
  }) {
    return _request(
      request: () => dio.delete(
        path,
        data: inputBody,
        queryParameters: queryParams,
        options: options,
      ),
      fromJson: fromJson,
    );
  }

  /// Multipart Multifile Upload
  Future<T> multipartMultifile<T>({
    required String path,
    required List<String> filePaths,
    required List<String> fileFields,
    Map<String, dynamic>? inputBody,
    Map<String, dynamic>? queryParams,
    required T Function(Map<String, dynamic>) fromJson,
    Options? options,
  }) async {
    if (filePaths.length != fileFields.length) {
      throw Exception("filePaths and fileFields must have the same length.");
    }

    final formData = FormData();

    for (int i = 0; i < filePaths.length; i++) {
      final filePath = filePaths[i];
      final fileField = fileFields[i];
      formData.files.add(
        MapEntry(
          fileField,
          await MultipartFile.fromFile(
            filePath,
            filename: filePath.split('/').last,
          ),
        ),
      );
    }

    if (inputBody != null) {
      formData.fields.addAll(
        inputBody.entries.map((e) => MapEntry(e.key, e.value.toString())),
      );
    }

    return _request(
      request: () => dio.post(
        path,
        data: formData,
        queryParameters: queryParams,
        options: options,
      ),
      fromJson: fromJson,
    );
  }
}
