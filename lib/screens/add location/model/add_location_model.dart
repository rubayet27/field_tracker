class AddLocationModel {
  String locationName;
  double latitude;
  double longitude;
  int radiusM;
  bool isActive;
  String id;

  AddLocationModel({
    required this.locationName,
    required this.latitude,
    required this.longitude,
    required this.radiusM,
    required this.isActive,
    required this.id,
  });

  factory AddLocationModel.fromJson(Map<String, dynamic> json) =>
      AddLocationModel(
        locationName: json["location_name"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        radiusM: json["radius_m"],
        isActive: json["is_active"],
        id: json["id"],
      );
}
class DeleteModel {
  bool success;

  DeleteModel({required this.success});

  factory DeleteModel.fromJson(Map<String, dynamic> json) =>
      DeleteModel(success: json["success"]);
}
