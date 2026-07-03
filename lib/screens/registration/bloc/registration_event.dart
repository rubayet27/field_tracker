abstract class RegistrationEvent {}

class RegistrationRequest extends RegistrationEvent{
  final String fullName;
  final String email;
  final String password;

  RegistrationRequest({required this.fullName, required this.email, required this.password});
}
