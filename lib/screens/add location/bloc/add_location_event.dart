import 'package:equatable/equatable.dart';

abstract class AddLocationEvent extends Equatable {
  const AddLocationEvent();

  @override
  List<Object?> get props => [];
}

class GetCurrentLocationEvent extends AddLocationEvent {
  const GetCurrentLocationEvent();
}

class UpdateGeofenceDetailsEvent extends AddLocationEvent {
  final double? latitude;
  final double? longitude;
  final double? radius;
  final String? locationName;

  const UpdateGeofenceDetailsEvent({
    this.latitude,
    this.longitude,
    this.radius,
    this.locationName,
  });

  @override
  List<Object?> get props => [latitude, longitude, radius, locationName];
}

class SaveLocationEvent extends AddLocationEvent {
  const SaveLocationEvent();
}

class ShowGeofenceNotificationEvent extends AddLocationEvent {
  const ShowGeofenceNotificationEvent();
}
