abstract class TaskEvent {}

class ChangeFilter extends TaskEvent {
  final int? filterIndex;
  ChangeFilter({required this.filterIndex});
}

class ToggleTaskCompletionEvent extends TaskEvent {
  final int taskId;
  final bool isCompleted;

  ToggleTaskCompletionEvent({required this.taskId, required this.isCompleted});
}

class GetTodos extends TaskEvent {}
