import 'package:field_tracker/core/widgets/primary_button.dart';
import 'package:field_tracker/core/widgets/primary_input_widget.dart';
import 'package:field_tracker/core/widgets/text_widget.dart';
import 'package:field_tracker/screens/login/bloc/login_bloc.dart';
import 'package:field_tracker/screens/login/bloc/login_state.dart';
import 'package:field_tracker/screens/login/features/brand_logo.dart';
import 'package:field_tracker/utils/app_colors.dart';
import 'package:field_tracker/utils/dimensions.dart';
import 'package:field_tracker/utils/layout_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/sizes/sizes.dart';
import '../bloc/login_event.dart';
import '../features/register_text_widget.dart';
import '../features/welcome_text.dart';
part 'login_phone_screen.dart';

class LoginScreen extends StatelessWidget{
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutManager(phoneLayout:LoginPhoneScreen() );
  }
}