import 'package:field_tracker/screens/navigation/bloc/navigation_event.dart';
import 'package:field_tracker/screens/navigation/bloc/navigation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState.initial()) {
    on<ChangeTab>((event, emit) {
      emit(state.copyWith(currentTab: event.tabIndex));
    });
  }
}
