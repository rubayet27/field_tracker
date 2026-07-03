import 'package:field_tracker/core/api%20base/api_endpoint/api_endpoints.dart';
import 'package:field_tracker/core/api%20base/api_request/api_call.dart';
import 'package:field_tracker/screens/tasks/bloc/task_event.dart';
import 'package:field_tracker/screens/tasks/bloc/task_state.dart';
import 'package:field_tracker/screens/tasks/model/task_model.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskState.initial()) {
    on<ChangeFilter>(_changeFilter);
    on<GetTodos>(_getTodos);
  }

  void _changeFilter(ChangeFilter event, Emitter<TaskState> emit) {
    final List<Datum>? filtered;
    debugPrint("${event.filterIndex}");
    if (state.data.isNotEmpty) {
      switch (event.filterIndex) {
        case 0:
          filtered = state.data;
          break;

        case 1:
          filtered = state.data.where((task) => !task.isCompleted).toList();
          break;

        case 2:
          filtered = state.data.where((task) => task.isCompleted).toList();
          break;

        default:
          filtered = state.filteredList;
      }
      emit(
        state.copyWith(
          status: TaskStatus.none,
          filterIndex: event.filterIndex,
          filteredList: filtered,
        ),
      );
    }
  }

  Future<void> _getTodos(GetTodos event, Emitter<TaskState> emit) async {
    emit(state.copyWith(status: TaskStatus.loading));

    await ApiCall.call(
      path: ApiEndpoints.getTodos,
      method: ApiMethodType.get,
      fromJson: TaskModel.fromJson,
      onSuccess: (value) {
        final completedCount = value.data
            .where((task) => task.isCompleted)
            .length;

        final pendingCount = value.data
            .where((task) => !task.isCompleted)
            .length;
        emit(
          state.copyWith(
            status: TaskStatus.success,
            data: value.data,
            filteredList: value.data,
            completed: completedCount,
            pending: pendingCount,
          ),
        );
      },
      isLoading: (loading) {},
    );
  }
}
