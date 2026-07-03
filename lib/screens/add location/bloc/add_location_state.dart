import 'package:equatable/equatable.dart';

class AddLocationState extends Equatable {
  final double? latitude;
  final double? longitude;
  final double radius;
  final String locationName;
  final bool isLoading;
  final String? message; // For success or error snackbar messages
  final bool isSuccess;

  const AddLocationState({
    this.latitude,
    this.longitude,
    this.radius = 100.0, // Default radius in meters
    this.locationName = '',
    this.isLoading = false,
    this.message,
    this.isSuccess = false,
  });

  AddLocationState copyWith({
    double? latitude,
    double? longitude,
    double? radius,
    String? locationName,
    bool? isLoading,
    String? message,
    bool? isSuccess,
  }) {
    return AddLocationState(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      radius: radius ?? this.radius,
      locationName: locationName ?? this.locationName,
      isLoading: isLoading ?? this.isLoading,
      message: message, // Allow setting message to null or a new value
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [
        latitude,
        longitude,
        radius,
        locationName,
        isLoading,
        message,
        isSuccess,
      ];
}
