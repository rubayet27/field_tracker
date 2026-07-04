import 'package:hive/hive.dart';

class PendingTodoChange {
  final String todoId;
  final bool isCompleted;
  final String title;
  final DateTime changedAt;

  PendingTodoChange({
    required this.todoId,
    required this.isCompleted,
    required this.title,
    required this.changedAt,
  });
}

class PendingTodoChangeAdapter extends TypeAdapter<PendingTodoChange> {
  @override
  final int typeId = 0;

  @override
  PendingTodoChange read(BinaryReader reader) {
    return PendingTodoChange(
      todoId: reader.readString(),
      isCompleted: reader.readBool(),
      title: reader.readString(),
      changedAt: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
    );
  }

  @override
  void write(BinaryWriter writer, PendingTodoChange obj) {
    writer.writeString(obj.todoId);
    writer.writeBool(obj.isCompleted);
    writer.writeString(obj.title);
    writer.writeInt(obj.changedAt.millisecondsSinceEpoch);
  }
}
