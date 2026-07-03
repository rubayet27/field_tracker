import 'package:field_tracker/screens/tasks/model/task_model.dart';

enum TaskStatus { initial, loading, success, failed, completed, pending, none }

class TaskState {
  final TaskStatus status;
  final List<Datum> data;
  final List<Datum> filteredList;
  final int? filterIndex;
  final int? completed;
  final int? pending;

  TaskState({
    required this.status,
    required this.data,
    this.filterIndex,
    this.completed,
    this.pending,
    required this.filteredList,
  });

  factory TaskState.initial() {
    return TaskState(
      status: TaskStatus.initial,
      data: const [],
      filteredList:const [],
      filterIndex: 0,
      completed: 0,
      pending: 0,
    );
  }

  TaskState copyWith({
    required TaskStatus status,
    List<Datum>? data,
    List<Datum>? filteredList,
    int? filterIndex,
    int? completed,
    int? pending,
  }) {
    return TaskState(
      status: status,
      data: data ?? this.data,
      filteredList: filteredList ?? this.filteredList,
      filterIndex: filterIndex ?? this.filterIndex,
      completed: completed ?? this.completed,
      pending: pending ?? this.pending,
    );
  }
}
