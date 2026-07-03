import 'package:field_tracker/screens/add%20location/bloc/add_location_bloc.dart';
import 'package:field_tracker/screens/add%20location/bloc/add_location_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/text_widget.dart';
import '../../../utils/app_colors.dart';
import '../bloc/add_location_event.dart';

class RadiusWidget extends StatelessWidget {
  const RadiusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return BlocBuilder<AddLocationBloc, AddLocationState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  'Geofence Radius',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                ),
                TextWidget(
                  '${state.radius.round()} m',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ],
            ),
            const SizedBox(height: 8),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: isDarkMode
                    ? AppColors.primaryDark
                    : AppColors.primary,
                inactiveTrackColor: isDarkMode
                    ? AppColors.disableLight
                    : AppColors.disableDark,
                thumbColor: isDarkMode
                    ? AppColors.primaryDark
                    : AppColors.primary,
                valueIndicatorColor: isDarkMode
                    ? AppColors.primaryDark
                    : AppColors.primary,
                trackHeight: 6,
                padding: EdgeInsets.zero,
                tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 0),
              ),
              child: Slider(
                value: state.radius,
                min: 50.0,
                max: 1000.0,
                divisions: 19,
                label: '${state.radius.round()}m',
                onChanged: (val) {
                  context.read<AddLocationBloc>().add(
                    UpdateGeofenceDetailsEvent(radius: val),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
