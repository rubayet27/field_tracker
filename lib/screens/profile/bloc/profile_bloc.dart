import 'package:field_tracker/core/api%20base/api_endpoint/api_endpoints.dart';
import 'package:field_tracker/core/api%20base/api_request/api_call.dart';
import 'package:field_tracker/screens/profile/bloc/profile_event.dart';
import 'package:field_tracker/utils/token_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/user_info_model.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<UserEvent, ProfileState> {
  ProfileBloc() : super(ProfileState.initial()) {
    on<GetUserInfo>(_getUserData);
    on<LogoutEvent>(_logout);
  }

  Future<void> _getUserData(
    GetUserInfo event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: UserStatus.loading));
    await ApiCall.call<UserInfoModel>(
      path: ApiEndpoints.getUser,
      method: ApiMethodType.get,
      fromJson: UserInfoModel.fromJson,
      requiresAuth: true,
      onSuccess: (value) {
        emit(state.copyWith(status: UserStatus.success, userData: value));
      },
      isLoading: (loading) {},
    );
  }

  Future<void> _logout(LogoutEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(logoutStatus: LogoutStatus.loading));
    await ApiCall.call<LogoutModel>(
      path: ApiEndpoints.logout,
      method: ApiMethodType.post,
      fromJson: LogoutModel.fromJson,
      onSuccess: (value) {
        emit(state.copyWith(logoutStatus: LogoutStatus.success));
        TokenManager.logout();
      },
      isLoading: (loading) {},
    );
  }
}
