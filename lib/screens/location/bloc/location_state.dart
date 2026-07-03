import 'package:field_tracker/screens/location/model/location_model.dart';

enum LocationStatus { initial, loading, success, failed }

class LocationState {
  final LocationStatus status;
  final List<Datum>? data;

  LocationState({required this.status, this.data});

  factory LocationState.initial() {
    return LocationState(status: LocationStatus.initial, data: []);
  }

  LocationState copyWith({LocationStatus? status, List<Datum>? data}) {
    return LocationState(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }
}
