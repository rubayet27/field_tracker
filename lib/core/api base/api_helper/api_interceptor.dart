import 'package:dio/dio.dart';
import 'package:field_tracker/core/api%20base/api_endpoint/api_endpoints.dart';
import 'package:field_tracker/screens/login/model/login_model.dart';

import '../../../routes/routes_list.dart';
import '../../../utils/token_manager.dart';
import '../../extensions/routes_extensions.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Check if this request requires authentication
    final bool requiresAuth = options.extra['requiresAuth'] ?? true;

    if (requiresAuth) {
      final String? accessToken = TokenManager.getAccessToken();

      if (accessToken != null && accessToken.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      } else {
        // Optional: You can handle missing token case here
        // For example, reject the request or let it proceed without token
      }
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final response = err.response;

    // Handle 401 Unauthorized - Token Expired
    if (response?.statusCode == 401 && err.requestOptions.path != ApiEndpoints.refreshToken) {
      final String? refreshToken = TokenManager.getRefreshToken();

      if (refreshToken != null && refreshToken.isNotEmpty) {
        try {
          // Use a clean Dio instance to avoid interceptor recursion or carrying headers
          final dioForRefresh = Dio(
            BaseOptions(
              baseUrl: ApiEndpoints.baseUrl,
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 15),
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              },
            ),
          );

          final refreshResponse = await dioForRefresh.post(
            ApiEndpoints.refreshToken,
            data: {"refresh_token": refreshToken},
          );

          if (refreshResponse.statusCode == 200 || refreshResponse.statusCode == 201) {
            final refreshModel = RefreshTokenModel.fromJson(refreshResponse.data);
            await TokenManager.saveAllTokens(
              accessToken: refreshModel.accessToken,
              refreshToken: refreshModel.refreshToken,
            );

            // Update the Authorization header of the original request
            final requestOptions = err.requestOptions;
            requestOptions.headers['Authorization'] = 'Bearer ${refreshModel.accessToken}';

            // Retry the original request
            final options = Options(
              method: requestOptions.method,
              headers: requestOptions.headers,
              extra: requestOptions.extra,
            );

            final retryResponse = await dioForRefresh.request(
              requestOptions.path,
              data: requestOptions.data,
              queryParameters: requestOptions.queryParameters,
              options: options,
            );

            return handler.resolve(retryResponse);
          }
        } catch (e) {
          await TokenManager.logout();
          Routes.login.push();
          return handler.reject(err);
        }
      } else {
        await TokenManager.logout();
        Routes.login.push();
      }
    }

    super.onError(err, handler);
  }
}

