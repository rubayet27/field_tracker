import 'package:field_tracker/core/extensions/routes_extensions.dart';
import 'package:field_tracker/core/widgets/primary_input_widget.dart';
import 'package:field_tracker/routes/routes_list.dart';
import 'package:field_tracker/screens/location/bloc/location_bloc.dart';
import 'package:field_tracker/screens/location/bloc/location_state.dart';
import 'package:field_tracker/screens/location/features/location_list.dart';
import 'package:field_tracker/utils/app_colors.dart';
import 'package:field_tracker/utils/dimensions.dart';
import 'package:field_tracker/utils/layout_manager.dart';
import 'package:field_tracker/utils/sizes/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/primary_app_bar.dart';
import '../bloc/location_event.dart';
part 'location_phone_screen.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutManager(phoneLayout: LocationPhoneScreen());
  }
}
