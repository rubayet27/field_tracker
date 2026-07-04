import 'package:field_tracker/core/widgets/primary_button.dart';
import 'package:field_tracker/routes/routes_list.dart';
import 'package:field_tracker/screens/profile/bloc/profile_bloc.dart';
import 'package:field_tracker/screens/profile/bloc/profile_state.dart';
import 'package:field_tracker/screens/profile/features/task_info.dart';
import 'package:field_tracker/utils/app_colors.dart';
import 'package:field_tracker/utils/layout_manager.dart';
import 'package:field_tracker/utils/sizes/border_radius.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extensions/routes_extensions.dart';
import '../../../core/widgets/primary_app_bar.dart';
import '../../../core/widgets/theme_toggle_widget.dart';
import '../../../utils/sizes/sizes.dart';
import '../bloc/profile_event.dart';
import '../features/menu_options.dart';
import '../features/user_info_widget.dart';
part 'profile_phone_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutManager(phoneLayout: ProfilePhoneScreen());
  }
}
