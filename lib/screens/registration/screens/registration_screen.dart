import 'package:field_tracker/screens/registration/bloc/registration_bloc.dart';
import 'package:field_tracker/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/primary_input_widget.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/layout_manager.dart';
import '../../../utils/sizes/sizes.dart';
import '../../login/features/brand_logo.dart';
import '../bloc/registration_event.dart';
import '../features/already_have_account.dart';
import '../features/create_account.dart';
part 'registration_phone_screen.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutManager(phoneLayout: RegistrationPhoneScreen());
  }
}
