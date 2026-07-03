import 'package:dio/dio.dart';

import '../api method/api_method.dart';
import '../api_helper/api_helper.dart';
import '../api_helper/api_exception.dart';

final apiMethod = getIt<ApiMethod>();

class ApiCall {
  static Future<void> call<T>({
    required String path,
    required ApiMethodType method,
    dynamic data,
    Map<String, dynamic>? queryParams,
    List<String>? filePaths,
    List<String>? fileFields,
    required T Function(Map<String, dynamic>) fromJson,
    required Function(T) onSuccess,
    Function(AppException)? onError,
    required Function(bool) isLoading,
    bool requiresAuth = true,
  }) async {
    isLoading(true);

    try {
      late final T result;

      final Options options = Options(extra: {'requiresAuth': requiresAuth});

      switch (method) {
        case ApiMethodType.get:
          result = await apiMethod.get(
            path: path,
            queryParams: queryParams,
            fromJson: fromJson,
            options: options,
          );
          break;
        case ApiMethodType.post:
          result = await apiMethod.post(
            path: path,
            inputBody: data,
            queryParams: queryParams,
            fromJson: fromJson,
            options: options,
          );
          break;
        case ApiMethodType.put:
          result = await apiMethod.put(
            path: path,
            inputBody: data,
            queryParams: queryParams,
            fromJson: fromJson,
            options: options,
          );
          break;
        case ApiMethodType.patch:
          result = await apiMethod.patch(
            path: path,
            inputBody: data,
            queryParams: queryParams,
            fromJson: fromJson,
            options: options,
          );
          break;
        case ApiMethodType.delete:
          result = await apiMethod.delete(
            path: path,
            fromJson: fromJson,
            inputBody: data,
            queryParams: queryParams,
            options: options,
          );
          break;
        case ApiMethodType.multipartMultifile:
          if (filePaths == null || fileFields == null) {
            throw Exception(
              "filePaths and fileFields are required for multipartMultifile method.",
            );
          }
          result = await apiMethod.multipartMultifile(
            path: path,
            filePaths: filePaths,
            fileFields: fileFields,
            inputBody: data,
            queryParams: queryParams,
            fromJson: fromJson,
            options: options,
          );
          break;
      }

      onSuccess(result);
    } catch (e) {
      if (onError != null) {
        if (e is AppException) {
          onError(e);
        } else {
          onError(AppException.fromObject(e));
        }
      }
    } finally {
      isLoading(false);
    }
  }
}

enum ApiMethodType { get, post, put, patch, delete, multipartMultifile }
