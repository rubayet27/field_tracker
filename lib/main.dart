import 'package:field_tracker/core/app%20theme/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app initializer/my_app.dart';
import 'core/api base/api_helper/api_helper.dart';
import 'utils/token_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TokenManager.init();
  ApiHelper.setup();
  runApp(BlocProvider(create: (_) => ThemeBloc(), child: const MyApp()));
}
