import 'package:field_tracker/screens/add%20location/bloc/add_location_bloc.dart';
import 'package:field_tracker/screens/add%20location/bloc/add_location_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/primary_input_widget.dart';
import '../../../core/widgets/text_widget.dart';
import '../../../utils/app_colors.dart';
import '../bloc/add_location_event.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController _locationNameController;
  final TextEditingController _latitudeController;
  final TextEditingController _longitudeController;

  const InputWidget({
    super.key,
    required this._locationNameController,
    required this._latitudeController,
    required this._longitudeController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return BlocBuilder<AddLocationBloc, AddLocationState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              'Location name',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
              padding: const EdgeInsets.only(bottom: 8),
            ),
            PrimaryInputWidget(
              controller: _locationNameController,
              hintText: 'Downtown Branch',
              isFilled: true,
              skipEnterText: true,
              radius: 14,
              borderWidth: 0.5,
              fillColor: isDarkMode
                  ? AppColors.componentDark
                  : AppColors.componentLight,
              onChanged: (val) {
                context.read<AddLocationBloc>().add(
                  UpdateGeofenceDetailsEvent(locationName: val),
                );
              },
            ),
            const SizedBox(height: 20),

            // Latitude and Longitude Display/Manual inputs
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        'Latitude',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                        padding: const EdgeInsets.only(bottom: 8),
                      ),
                      PrimaryInputWidget(
                        controller: _latitudeController,
                        hintText: 'e.g. 23.8103',
                        skipEnterText: true,
                        isFilled: true,
                        radius: 14,
                        borderWidth: 0.5,
                        fillColor: isDarkMode
                            ? AppColors.componentDark
                            : AppColors.componentLight,
                        textInputType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        onChanged: (val) {
                          final lat = double.tryParse(val);
                          context.read<AddLocationBloc>().add(
                            UpdateGeofenceDetailsEvent(latitude: lat),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        'Longitude',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                        padding: const EdgeInsets.only(bottom: 8),
                      ),
                      PrimaryInputWidget(
                        controller: _longitudeController,
                        hintText: 'e.g. 90.4125',
                        isFilled: true,
                        skipEnterText: true,
                        radius: 14,
                        borderWidth: 0.5,
                        fillColor: isDarkMode
                            ? AppColors.componentDark
                            : AppColors.componentLight,
                        textInputType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        onChanged: (val) {
                          final lng = double.tryParse(val);
                          context.read<AddLocationBloc>().add(
                            UpdateGeofenceDetailsEvent(longitude: lng),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
