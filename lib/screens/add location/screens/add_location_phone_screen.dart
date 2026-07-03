import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/primary_app_bar.dart';
import '../../../utils/sizes/sizes.dart';
import '../bloc/add_location_bloc.dart';
import '../bloc/add_location_event.dart';
import '../bloc/add_location_state.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/text_widget.dart';
import '../../../utils/app_colors.dart';
import '../features/input_widget.dart';
import '../features/map_widget.dart';
import '../features/radius_widget.dart';

class AddLocationPhoneScreen extends StatefulWidget {
  const AddLocationPhoneScreen({super.key});

  @override
  State<AddLocationPhoneScreen> createState() => _AddLocationPhoneScreenState();
}

class _AddLocationPhoneScreenState extends State<AddLocationPhoneScreen> {
  final TextEditingController _locationNameController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

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

    return BlocConsumer<AddLocationBloc, AddLocationState>(
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
              title: "New Location",
              onBackPressed: () {
                Future.delayed(const Duration(seconds: 1), () {
                  if (context.mounted && Navigator.of(context).canPop()) {
                    Navigator.of(context).pop(true);
                  }
                });
              },
            ),
            body: SingleChildScrollView(
              padding: Sizes.padding.ph20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MapWidget(),
                  Sizes.height.h10,
                  GestureDetector(
                    onTap: () {
                      context.read<AddLocationBloc>().add(
                        const GetCurrentLocationEvent(),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 54,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.6),
                          width: 1.5,
                          style: BorderStyle
                              .solid, // dashed simulated via styling or simple border
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
                  InputWidget(
                    latitudeController: _latitudeController,
                    longitudeController: _longitudeController,
                    locationNameController: _locationNameController,
                  ),
                  Sizes.height.h20,

                  // Radius slider
                  RadiusWidget(),
                  Sizes.height.h32,

                  // Save Location Button
                  PrimaryButton(
                    title: 'Save Location',
                    isLoading: state.isLoading,
                    buttonColor: AppColors.primary,
                    onPressed: () {
                      context.read<AddLocationBloc>().add(
                        const SaveLocationEvent(),
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
