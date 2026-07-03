import 'package:equatable/equatable.dart';

abstract class EditLocationEvent extends Equatable {
  const EditLocationEvent();

  @override
  List<Object?> get props => [];
}

class GetCurrentLocationEvent extends EditLocationEvent {
  const GetCurrentLocationEvent();
}

class UpdateGeofenceDetailsEvent extends EditLocationEvent {
  final double? latitude;
  final double? longitude;
  final double? radius;
  final String? locationName;
  final bool? isActive;

  const UpdateGeofenceDetailsEvent({
    this.latitude,
    this.longitude,
    this.radius,
    this.locationName,
    this.isActive,
  });

  @override
  List<Object?> get props => [
    latitude,
    longitude,
    radius,
    locationName,
    isActive,
  ];
}

class SaveLocationEvent extends EditLocationEvent {
  const SaveLocationEvent();
}

class DeleteLocationEvent extends EditLocationEvent {
  const DeleteLocationEvent();
}

class ShowGeofenceNotificationEvent extends EditLocationEvent {
  const ShowGeofenceNotificationEvent();
}
