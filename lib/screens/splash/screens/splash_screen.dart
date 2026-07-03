import 'package:field_tracker/core/extensions/routes_extensions.dart';
import 'package:field_tracker/screens/login/features/brand_logo.dart';
import 'package:field_tracker/screens/splash/bloc/splash_bloc.dart';
import 'package:field_tracker/screens/splash/bloc/splash_state.dart';
import 'package:field_tracker/utils/layout_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes/routes_list.dart';

part 'splash_phone_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutManager(phoneLayout: SplashPhoneScreen());
  }
}
