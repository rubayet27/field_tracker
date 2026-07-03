import 'package:field_tracker/core/api%20base/api_request/api_call.dart';
import 'package:field_tracker/screens/login/model/login_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/api base/api_endpoint/api_endpoints.dart';
import '../../../core/extensions/routes_extensions.dart';
import '../../../routes/routes_list.dart';
import '../../../utils/token_manager.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<LoginRequest>(_login);
  }

  Future<void> _login(LoginRequest event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.loading));

    await ApiCall.call<LoginModel>(
      path: ApiEndpoints.login,
      data: {"email": event.email, "password": event.password},
      method: ApiMethodType.post,
      fromJson: LoginModel.fromJson,
      requiresAuth: false,
      onSuccess: (value) {
        emit(state.copyWith(status: LoginStatus.success, user: value));
        TokenManager.saveAllTokens(
          accessToken: value.accessToken,
          refreshToken: value.refreshToken,
        ).then((_) {
          Routes.navigation.go();
        });
      },
      isLoading: (value) {},
      onError: (value) {
        emit(state.copyWith(status: LoginStatus.failure));
      },
    );
  }
}
