import 'package:field_tracker/screens/login/model/login_model.dart';


enum LoginStatus { initial, loading, success, failure }

class LoginState {
  final LoginStatus status;
  final LoginModel? user;
  final String? errorMessage;

  const LoginState({
    required this.status,
    this.user,
    this.errorMessage,
  });

  factory LoginState.initial() {
    return const LoginState(status: LoginStatus.initial);
  }

  LoginState copyWith({
    LoginStatus? status,
    LoginModel? user,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage,
    );
  }
}
