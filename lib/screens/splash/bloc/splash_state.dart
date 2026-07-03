enum SplashStatus { initial, authenticated, unauthenticated }

class SplashState {
  final SplashStatus status;

  SplashState({required this.status});

  factory SplashState.initial() {
    return SplashState(status: SplashStatus.initial);
  }

  SplashState copyWith({SplashStatus? status}) {
    return SplashState(status: status ?? this.status);
  }
}
