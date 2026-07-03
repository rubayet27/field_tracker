class LocationModel {
  List<Datum> data;

  LocationModel({required this.data});

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );
}

class Datum {
  String locationName;
  double latitude;
  double longitude;
  double radiusM;
  bool isActive;
  String id;

  Datum({
    required this.locationName,
    required this.latitude,
    required this.longitude,
    required this.radiusM,
    required this.isActive,
    required this.id,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    locationName: json["location_name"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    radiusM: json["radius_m"]?.toDouble(),
    isActive: json["is_active"],
    id: json["id"],
  );
}
