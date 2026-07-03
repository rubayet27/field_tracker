import 'package:field_tracker/screens/navigation/bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extensions/responsive_extensions.dart';
import '../../../core/extensions/routes_extensions.dart';
import '../../../routes/routes_list.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/layout_manager.dart';
import '../../../utils/sizes/border_radius.dart';
import '../../../utils/sizes/sizes.dart';
part 'home_phone_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutManager(phoneLayout: HomePhoneScreen());
  }
}
