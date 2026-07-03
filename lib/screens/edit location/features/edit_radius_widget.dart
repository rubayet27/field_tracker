import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/text_widget.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/sizes/sizes.dart';
import '../bloc/edit_location_bloc.dart';
import '../bloc/edit_location_event.dart';
import '../bloc/edit_location_state.dart';

class EditRadiusWidget extends StatelessWidget {
  const EditRadiusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return BlocBuilder<EditLocationBloc, EditLocationState>(
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
            Sizes.height.h8,
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
                  context.read<EditLocationBloc>().add(
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
