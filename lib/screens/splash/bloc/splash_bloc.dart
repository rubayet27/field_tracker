import 'package:field_tracker/screens/splash/bloc/splash_event.dart';
import 'package:field_tracker/screens/splash/bloc/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/token_manager.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashState.initial()) {
    on<SplashRoute>(_getTokenState);
  }

  Future<void> _getTokenState(
    SplashRoute event,
    Emitter<SplashState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 2));

    final token = TokenManager.getAccessToken();

    if (token != null && token.isNotEmpty) {
      emit(state.copyWith(status: SplashStatus.authenticated));
    } else {
      emit(state.copyWith(status: SplashStatus.unauthenticated));
    }
  }
}
