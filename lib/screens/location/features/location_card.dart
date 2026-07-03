import 'package:field_tracker/core/extensions/routes_extensions.dart';
import 'package:field_tracker/routes/routes_list.dart';
import 'package:field_tracker/screens/location/bloc/location_bloc.dart';
import 'package:field_tracker/screens/location/bloc/location_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:field_tracker/core/widgets/text_widget.dart';
import 'package:field_tracker/utils/dimensions.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/sizes/border_radius.dart';
import '../../../utils/sizes/sizes.dart';
import '../model/location_model.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({super.key, required this.location});
  final Datum location;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isActive = location.isActive;
    return GestureDetector(
      onTap: () async {
        final result = await Routes.editLocation.push<bool>(extra: location);
        if (result == true && context.mounted) {
          context.read<LocationBloc>().add(GetAllLocation());
        }
      },
      child: Card(
        color: !isDark ? AppColors.componentLight : AppColors.componentDark,
        child: Padding(
          padding: Sizes.padding.p16,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              _locationIcon(isDark: isDark),
              Sizes.width.w16,
              _dataWidget(isDark: isDark),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios_outlined,
                size: Dimensions.iconSm,
                color: isActive
                    ? isDark
                          ? AppColors.disableDark
                          : AppColors.disableLight
                    : AppColors.disableDark,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _locationIcon({bool? isDark}) {
    final bool isActive = location.isActive;
    return Container(
      padding: Sizes.padding.p10,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        color: !isDark!
            ? isActive
                  ? AppColors.primaryDark.withValues(alpha: 0.15)
                  : AppColors.disableLight
            : AppColors.primary.withValues(alpha: 0.15),
      ),
      child: Icon(
        Icons.place_outlined,
        color: !isDark
            ? isActive
                  ? AppColors.primary
                  : AppColors.disableDark
            : AppColors.primaryDark,
      ),
    );
  }

  Column _dataWidget({bool? isDark}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextWidget(
          location.locationName,
          fontSize: Dimensions.titleMedium,
          fontWeight: FontWeight.bold,
        ),
        _latLong(),
        Sizes.height.h8,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _radius(isDark: isDark),
            Sizes.width.w8,
            _status(isDark: isDark),
          ],
        ),
      ],
    );
  }

  Row _latLong() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.location_searching_sharp, size: Dimensions.iconSm * 0.8),
        TextWidget(
          location.latitude.toString(),
          fontSize: Dimensions.labelSmall,
        ),
        TextWidget(
          location.longitude.toString(),
          fontSize: Dimensions.labelSmall,
        ),
      ],
    );
  }

  Container _status({bool? isDark}) {
    final bool isActive = location.isActive;
    return Container(
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.success.withValues(alpha: 0.2)
            : !isDark!
            ? AppColors.disableDark
            : AppColors.disableLight,
        borderRadius: BorderRadius.circular(AppRadius.sm * 0.8),
      ),
      padding: Sizes.padding.psym(h: 10, v: 3),
      child: TextWidget(
        isActive ? "Active" : "Inactive",
        fontSize: Dimensions.labelMedium,
        fontWeight: FontWeight.bold,
        color: isActive
            ? AppColors.success
            : !isDark!
            ? AppColors.disableLight
            : AppColors.disableDark,
      ),
    );
  }

  Container _radius({bool? isDark}) {
    return Container(
      decoration: BoxDecoration(
        color: !isDark! ? AppColors.disableDark : AppColors.disableLight,
        borderRadius: BorderRadius.circular(AppRadius.sm * 0.8),
      ),
      padding: Sizes.padding.psym(h: 10, v: 3),
      child: TextWidget(
        "${location.radiusM.toStringAsFixed(2)}m radius",
        fontSize: Dimensions.labelMedium,
        color: !isDark ? AppColors.disableLight : AppColors.disableDark,
      ),
    );
  }
}
