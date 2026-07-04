import 'package:field_tracker/core/app%20theme/bloc/theme_bloc.dart';
import 'package:field_tracker/screens/sync/model/pending_todo_change.dart';
import 'package:field_tracker/screens/sync/service/connectivity_service.dart';
import 'package:field_tracker/screens/sync/service/todo_sync_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app initializer/my_app.dart';
import 'core/api base/api_helper/api_helper.dart';
import 'utils/token_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TokenManager.init();
  ApiHelper.setup();

  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(PendingTodoChangeAdapter());

  // Initialize and register services
  final todoSyncService = TodoSyncService();
  await todoSyncService.init();
  getIt.registerSingleton<TodoSyncService>(todoSyncService);

  final connectivityService = ConnectivityService();
  await connectivityService.init();
  getIt.registerSingleton<ConnectivityService>(connectivityService);

  // Auto-sync when connectivity is restored
  connectivityService.onlineStream.listen((isOnline) {
    if (isOnline) {
      todoSyncService.syncPendingChanges();
    }
  });

  runApp(BlocProvider(create: (_) => ThemeBloc(), child: const MyApp()));
}
