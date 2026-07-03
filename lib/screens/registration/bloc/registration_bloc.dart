import 'package:field_tracker/screens/registration/bloc/registration_event.dart';
import 'package:field_tracker/screens/registration/bloc/registration_state.dart';
import 'package:field_tracker/screens/registration/model/registration_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/api base/api_endpoint/api_endpoints.dart';
import '../../../core/api base/api_request/api_call.dart';
import '../../../core/extensions/routes_extensions.dart';
import '../../../routes/routes_list.dart';
import '../../../utils/token_manager.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationState.initial()) {
    on<RegistrationRequest>(_registration);
  }

  Future<void> _registration(
    RegistrationRequest event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(state.copyWith(status: RegistrationStatus.loading));

    await ApiCall.call<RegistrationModel>(
      path: ApiEndpoints.register,
      data: {
        "email": event.email,
        "password": event.password,
        "full_name": event.fullName,
      },
      method: ApiMethodType.post,
      fromJson: RegistrationModel.fromJson,
      requiresAuth: false,
      onSuccess: (value) {
        emit(state.copyWith(status: RegistrationStatus.success, user: value));
        TokenManager.saveAllTokens(
          accessToken: value.accessToken,
          refreshToken: value.refreshToken,
        ).then((_) => Routes.navigation.go());
      },
      isLoading: (value) {},
      onError: (value) {
        emit(state.copyWith(status: RegistrationStatus.failed));
      },
    );
  }
}
