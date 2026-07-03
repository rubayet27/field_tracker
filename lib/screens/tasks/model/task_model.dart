class TaskModel {
  List<Datum> data;

  TaskModel({required this.data});

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );
}

class Datum {
  String title;
  String description;
  bool isCompleted;
  DateTime dueAt;
  String id;

  Datum({
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.dueAt,
    required this.id,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    title: json["title"],
    description: json["description"],
    isCompleted: json["is_completed"],
    dueAt: DateTime.parse(json["due_at"]),
    id: json["id"],
  );
}
