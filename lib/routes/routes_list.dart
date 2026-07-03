import 'package:field_tracker/screens/add%20location/bloc/add_location_bloc.dart';
import 'package:field_tracker/screens/add%20location/screens/add_location_screen.dart';
import 'package:field_tracker/screens/edit%20location/bloc/edit_location_bloc.dart';
import 'package:field_tracker/screens/edit%20location/screens/edit_location_screen.dart';
import 'package:field_tracker/screens/location/model/location_model.dart';
import 'package:field_tracker/screens/location/bloc/location_bloc.dart';
import 'package:field_tracker/screens/login/screens/login_screen.dart';
import 'package:field_tracker/screens/navigation/bloc/navigation_bloc.dart';
import 'package:field_tracker/screens/navigation/screens/navigation_screen.dart';
import 'package:field_tracker/screens/registration/screens/registration_screen.dart';
import 'package:field_tracker/screens/splash/bloc/splash_bloc.dart';
import 'package:field_tracker/screens/splash/bloc/splash_event.dart';
import 'package:field_tracker/screens/splash/screens/splash_screen.dart';
import 'package:field_tracker/screens/tasks/bloc/task_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../screens/home/screens/home_screen.dart';
import '../screens/location/bloc/location_event.dart';
import '../screens/login/bloc/login_bloc.dart';
import '../screens/profile/bloc/profile_bloc.dart';
import '../screens/profile/bloc/profile_event.dart';
import '../screens/tasks/bloc/task_bloc.dart';

part 'routes_pages.dart';


class Routes {
  static String home = "home";
  static String splash = "splash";
  static String login = "login";
  static String registration = "registration";
  static String navigation = "navigation";
  static String addLocation = "addLocation";
  static String editLocation = "editLocation";
}
