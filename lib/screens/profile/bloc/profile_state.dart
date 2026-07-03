import '../model/user_info_model.dart';

enum UserStatus { initial, loading, success, failed }

class ProfileState {
  final UserStatus status;
  final UserInfoModel? userData;
  final LogoutStatus? logoutstatus;

  ProfileState({required this.status, this.userData, this.logoutstatus});

  factory ProfileState.initial() {
    return ProfileState(
      status: UserStatus.initial,
      logoutstatus: LogoutStatus.initial,
    );
  }

  ProfileState copyWith({
    UserStatus? status,
    UserInfoModel? userData,
    LogoutStatus? logoutStatus,
  }) {
    return ProfileState(
      status: status ?? this.status,
      userData: userData ?? this.userData,
      logoutstatus: logoutStatus ?? logoutstatus,
    );
  }
}

enum LogoutStatus { initial, loading, success }
