import 'package:field_tracker/core/widgets/text_widget.dart';
import 'package:field_tracker/screens/profile/bloc/profile_bloc.dart';
import 'package:field_tracker/screens/profile/bloc/profile_state.dart';
import 'package:field_tracker/utils/dimensions.dart';
import 'package:field_tracker/utils/sizes/border_radius.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/sizes/sizes.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state.status == UserStatus.success && state.userData != null) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              padding: Sizes.padding.p24,
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.componentDark
                    : AppColors.componentLight,
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _imageWidget(context),
                  Sizes.height.h16,
                  _nameInfo(
                    name: state.userData!.name,
                    email: state.userData!.email,
                  ),
                ],
              ),
            ),
          );
        }

        if (state.status == UserStatus.failed) {
          return const Center(child: Text('Failed to load user info'));
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  CircleAvatar _imageWidget(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return CircleAvatar(
      radius: AppRadius.lg * 3,
      backgroundColor: isDark ? AppColors.primaryDark : AppColors.primary,
    );
  }

  Column _nameInfo({String? name, String? email}) {
    return Column(
      children: [
        TextWidget(name ?? "", fontSize: Dimensions.titleLarge),
        TextWidget(email ?? "", fontSize: Dimensions.titleSmall),
      ],
    );
  }
}
