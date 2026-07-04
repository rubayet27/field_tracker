import 'package:field_tracker/core/api%20base/api_endpoint/api_endpoints.dart';
import 'package:field_tracker/core/api%20base/api_helper/api_helper.dart';
import 'package:field_tracker/core/api%20base/api_request/api_call.dart';
import 'package:field_tracker/screens/sync/service/todo_sync_service.dart';
import 'package:field_tracker/screens/tasks/bloc/task_event.dart';
import 'package:field_tracker/screens/tasks/bloc/task_state.dart';
import 'package:field_tracker/screens/tasks/model/task_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskState.initial()) {
    on<ChangeFilter>(_changeFilter);
    on<GetTodos>(_getTodos);
    on<ToggleTaskCompletionEvent>(_toggleTask);
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
        // Apply any pending local changes on top of API data
        final syncService = getIt<TodoSyncService>();
        final pendingChanges = syncService.getPendingChanges();

        for (final change in pendingChanges) {
          final index = value.data.indexWhere((d) => d.id == change.todoId);
          if (index != -1) {
            value.data[index].isCompleted = change.isCompleted;
          }
        }

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

  Future<void> _toggleTask(
    ToggleTaskCompletionEvent event,
    Emitter<TaskState> emit,
  ) async {
    // 1. Optimistic UI update — flip the item immediately
    final updatedData = state.data.map((task) {
      if (task.id == event.taskId) {
        task.isCompleted = event.isCompleted;
      }
      return task;
    }).toList();

    final completedCount = updatedData.where((task) => task.isCompleted).length;
    final pendingCount = updatedData.where((task) => !task.isCompleted).length;

    // Re-apply the current filter
    List<Datum> updatedFiltered;
    switch (state.filterIndex) {
      case 1:
        updatedFiltered = updatedData
            .where((task) => !task.isCompleted)
            .toList();
        break;
      case 2:
        updatedFiltered = updatedData
            .where((task) => task.isCompleted)
            .toList();
        break;
      default:
        updatedFiltered = updatedData;
    }

    emit(
      state.copyWith(
        status: TaskStatus.none,
        data: updatedData,
        filteredList: updatedFiltered,
        completed: completedCount,
        pending: pendingCount,
      ),
    );

    // 2. Try to PATCH the change to the API
    final todoTitle = updatedData.firstWhere((t) => t.id == event.taskId).title;

    try {
      final dio = getIt<ApiHelper>().dio;
      final response = await dio.patch(
        ApiEndpoints.patchTodo(event.taskId),
        data: {
          'is_completed': event.isCompleted,
          "updated_at": getCurrentIsoUtc(),
        },
        options: Options(extra: {'requiresAuth': true}),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        debugPrint('✅ Todo ${event.taskId} patched successfully');
        // If this item was previously pending, remove it
        final syncService = getIt<TodoSyncService>();
        await syncService.removePendingChange(event.taskId);
      } else {
        // API returned non-success, queue for later
        await _queueChange(event.taskId, event.isCompleted, todoTitle);
      }
    } catch (e) {
      // 3. Network error — queue the change for offline sync
      debugPrint('⚠️ Offline or error, queuing change: $e');
      await _queueChange(event.taskId, event.isCompleted, todoTitle);
    }
  }

  String getCurrentIsoUtc() {
    final now = DateTime.now().toUtc(); // Convert to UTC
    final formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
    return formatter.format(now);
  }

  Future<void> _queueChange(
    String todoId,
    bool isCompleted,
    String title,
  ) async {
    final syncService = getIt<TodoSyncService>();
    await syncService.addPendingChange(
      todoId: todoId,
      isCompleted: isCompleted,
      title: title,
    );
    debugPrint('📦 Queued change for todo: $todoId');
  }
}
