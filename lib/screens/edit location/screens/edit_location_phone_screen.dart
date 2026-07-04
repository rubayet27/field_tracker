import 'package:field_tracker/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/primary_app_bar.dart';
import '../../../utils/sizes/sizes.dart';
import '../bloc/edit_location_bloc.dart';
import '../bloc/edit_location_event.dart';
import '../bloc/edit_location_state.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/text_widget.dart';
import '../../../utils/app_colors.dart';
import '../features/edit_input_widget.dart';
import '../features/edit_map_widget.dart';
import '../features/edit_radius_widget.dart';

class EditLocationPhoneScreen extends StatefulWidget {
  const EditLocationPhoneScreen({super.key});

  @override
  State<EditLocationPhoneScreen> createState() =>
      _EditLocationPhoneScreenState();
}

class _EditLocationPhoneScreenState extends State<EditLocationPhoneScreen> {
  late final TextEditingController _locationNameController;
  late final TextEditingController _latitudeController;
  late final TextEditingController _longitudeController;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<EditLocationBloc>();
    _locationNameController = TextEditingController(
      text: bloc.state.locationName,
    );
    _latitudeController = TextEditingController(
      text: bloc.state.latitude != null
          ? bloc.state.latitude!.toStringAsFixed(6)
          : '',
    );
    _longitudeController = TextEditingController(
      text: bloc.state.longitude != null
          ? bloc.state.longitude!.toStringAsFixed(6)
          : '',
    );
  }

  @override
  void dispose() {
    _locationNameController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return BlocConsumer<EditLocationBloc, EditLocationState>(
      listener: (context, state) {
        if (state.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message!),
              backgroundColor: state.isSuccess
                  ? AppColors.success
                  : AppColors.error,
              duration: const Duration(seconds: 3),
            ),
          );
        }

        // Update controllers when coordinates change from Bloc (GPS fetch)
        if (state.latitude != null) {
          _latitudeController.text = state.latitude!.toStringAsFixed(6);
        }
        if (state.longitude != null) {
          _longitudeController.text = state.longitude!.toStringAsFixed(6);
        }

        if (state.isSuccess) {
          // Success action (pop screen or go back)
          Future.delayed(const Duration(seconds: 1), () {
            if (context.mounted && Navigator.of(context).canPop()) {
              Navigator.of(context).pop(true);
            }
          });
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: PrimaryAppBarWidget(
              title: "Edit Location",
              onBackPressed: () {
                Future.delayed(const Duration(seconds: 1), () {
                  if (context.mounted && Navigator.of(context).canPop()) {
                    Navigator.of(context).pop(true);
                  }
                });
              },
            ),
            body: SingleChildScrollView(
              padding: Sizes.padding.p24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const EditMapWidget(),
                  Sizes.height.h10,

                  // Use current location button (Dashed border look)
                  GestureDetector(
                    onTap: () {
                      context.read<EditLocationBloc>().add(
                        const GetCurrentLocationEvent(),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 54,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.04),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.6),
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.my_location,
                            color: AppColors.primary,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          TextWidget(
                            'Use my current location',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Sizes.height.h20,
                  EditInputWidget(
                    latitudeController: _latitudeController,
                    longitudeController: _longitudeController,
                    locationNameController: _locationNameController,
                  ),
                  Sizes.height.h20,

                  const EditRadiusWidget(),
                  Sizes.height.h20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            'Active',
                            fontSize: Dimensions.titleMedium,
                            fontWeight: FontWeight.bold,
                          ),
                          TextWidget(
                            "Worker's can check in here",
                            fontSize: Dimensions.labelMedium,
                          ),
                        ],
                      ),
                      Switch(
                        value: state.isActive,
                        activeThumbColor: AppColors.white,
                        activeTrackColor: isDarkMode
                            ? AppColors.primaryDark
                            : AppColors.primary,

                        onChanged: (val) {
                          context.read<EditLocationBloc>().add(
                            UpdateGeofenceDetailsEvent(isActive: val),
                          );
                        },
                      ),
                    ],
                  ),
                  Sizes.height.h32,
                  PrimaryButton(
                    title: 'Update Location',
                    isLoading: state.isLoading,
                    buttonColor: AppColors.primary,
                    onPressed: () {
                      context.read<EditLocationBloc>().add(
                        const SaveLocationEvent(),
                      );
                    },
                  ),

                  Sizes.height.h10,
                  PrimaryButton(
                    title: 'Delete Location',
                    isLoading: state.isLoading,
                    buttonColor: AppColors.transparent,
                    buttonTextColor: AppColors.error,
                    borderColor: AppColors.error,
                    borderWidth: 1,
                    icon: Icon(
                      Icons.delete_outline_outlined,
                      color: AppColors.error,
                      size: Dimensions.iconLg,
                    ),
                    onPressed: () {
                      context.read<EditLocationBloc>().add(
                        const DeleteLocationEvent(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
