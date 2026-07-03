import 'package:field_tracker/screens/registration/model/registration_model.dart';

enum RegistrationStatus { initial, loading, success, failed }

class RegistrationState {
  final RegistrationStatus status;
  final RegistrationModel? user;
  final String? errorMessage;

  RegistrationState({required this.status, this.user, this.errorMessage});

  factory RegistrationState.initial() {
    return RegistrationState(status: RegistrationStatus.initial);
  }

  RegistrationState copyWith({
    RegistrationStatus? status,
    RegistrationModel? user,
    final String? errorMessage,
  }) {
    return RegistrationState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage,
    );
  }
}
