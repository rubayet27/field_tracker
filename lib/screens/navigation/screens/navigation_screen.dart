import 'package:field_tracker/screens/location/screens/location_screen.dart';
import 'package:field_tracker/screens/navigation/bloc/navigation_bloc.dart';
import 'package:field_tracker/screens/navigation/bloc/navigation_state.dart';
import 'package:field_tracker/utils/layout_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../profile/screens/profile_screen.dart';
import '../../sync/screens/sync_screen.dart';
import '../../tasks/screens/task_screen.dart';
import '../features/navigation_bar_widget.dart';
part 'navigation_phone_screen.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutManager(phoneLayout:NavigationPhoneScreen() );
  }
}