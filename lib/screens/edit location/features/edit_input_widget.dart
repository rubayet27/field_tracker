import 'package:field_tracker/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/primary_input_widget.dart';
import '../../../core/widgets/text_widget.dart';
import '../bloc/edit_location_bloc.dart';
import '../bloc/edit_location_event.dart';
import '../bloc/edit_location_state.dart';

class EditInputWidget extends StatelessWidget {
  final TextEditingController _locationNameController;
  final TextEditingController _latitudeController;
  final TextEditingController _longitudeController;

  const EditInputWidget({
    super.key,
    required this._locationNameController,
    required this._latitudeController,
    required this._longitudeController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return BlocBuilder<EditLocationBloc, EditLocationState>(
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
              hintText: '',
              isFilled: true,
              skipEnterText: true,
              radius: 14,
              borderWidth: 0.5,
              fillColor: isDarkMode
                  ? AppColors.componentDark
                  : AppColors.componentLight,
              onChanged: (val) {
                context.read<EditLocationBloc>().add(
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
                        hintText: '',
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
                          context.read<EditLocationBloc>().add(
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
                        hintText: '',
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
                          context.read<EditLocationBloc>().add(
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
