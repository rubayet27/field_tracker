import 'package:equatable/equatable.dart';

class EditLocationState extends Equatable {
  final String id;
  final double? latitude;
  final double? longitude;
  final double radius;
  final String locationName;
  final bool isActive;
  final bool isLoading;
  final String? message; 
  final bool isSuccess;
  final bool isDeleteLoading;

  const EditLocationState({
    required this.id,
    this.latitude,
    this.longitude,
    this.radius = 100.0, 
    this.locationName = '',
    this.isActive = true,
    this.isLoading = false,
    this.message,
    this.isSuccess = false,
    this.isDeleteLoading = false,
  });

  EditLocationState copyWith({
    String? id,
    double? latitude,
    double? longitude,
    double? radius,
    String? locationName,
    bool? isActive,
    bool? isLoading,
    String? message,
    bool? isSuccess,
    bool? isDeleteLoading,
  }) {
    return EditLocationState(
      id: id ?? this.id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      radius: radius ?? this.radius,
      locationName: locationName ?? this.locationName,
      isActive: isActive ?? this.isActive,
      isLoading: isLoading ?? this.isLoading,
      message: message, 
      isSuccess: isSuccess ?? this.isSuccess,
      isDeleteLoading: isDeleteLoading??this.isDeleteLoading
    );
  }

  @override
  List<Object?> get props => [
    id,
    latitude,
    longitude,
    radius,
    locationName,
    isActive,
    isLoading,
    message,
    isSuccess,
    isDeleteLoading
  ];
}
