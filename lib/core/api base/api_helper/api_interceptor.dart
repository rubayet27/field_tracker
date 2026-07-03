import 'package:dio/dio.dart';
import 'package:field_tracker/core/api%20base/api_endpoint/api_endpoints.dart';
import 'package:field_tracker/screens/login/model/login_model.dart';

import '../../../routes/routes_list.dart';
import '../../../utils/token_manager.dart';
import '../../extensions/routes_extensions.dart';
import '../api_request/api_call.dart';

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
    if (response?.statusCode == 401) {
      final String? refreshToken = TokenManager.getRefreshToken();

      if (refreshToken != null && refreshToken.isNotEmpty) {
        return _refreshToken();
      } else {
        await TokenManager.logout();
      }
    }

    super.onError(err, handler);
  }

  Future<void> _refreshToken() async {
    return ApiCall.call<RefreshTokenModel>(
      path: ApiEndpoints.refreshToken,
      method: ApiMethodType.post,
      data: {"refresh_token": TokenManager.getRefreshToken()},
      fromJson: RefreshTokenModel.fromJson,
      onSuccess: (value) {
        TokenManager.saveAllTokens(
          accessToken: value.accessToken,
          refreshToken: value.refreshToken,
        ).then((_) => Routes.navigation.push());
      },
      isLoading: (loading) {},
    );
  }
}
