import 'package:dio/dio.dart';
import 'package:field_tracker/core/api%20base/api_endpoint/api_endpoints.dart';
import 'package:field_tracker/core/api%20base/api_helper/api_helper.dart';
import 'package:field_tracker/screens/sync/model/pending_todo_change.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class TodoSyncService {
  static const String _boxName = 'pendingTodoChanges';
  static const String _metaBoxName = 'syncMeta';
  static const String _lastSyncKey = 'lastSyncTime';

  late Box<PendingTodoChange> _pendingBox;
  late Box _metaBox;

  Future<void> init() async {
    _pendingBox = await Hive.openBox<PendingTodoChange>(_boxName);
    _metaBox = await Hive.openBox(_metaBoxName);
  }

  /// Adds or updates a pending change keyed by todoId (upsert).
  /// If user toggles the same item multiple times offline,
  /// only the latest state is kept.
  Future<void> addPendingChange({
    required String todoId,
    required bool isCompleted,
    required String title,
  }) async {
    final change = PendingTodoChange(
      todoId: todoId,
      isCompleted: isCompleted,
      title: title,
      changedAt: DateTime.now(),
    );
    await _pendingBox.put(todoId, change);
  }

  /// Removes a pending change (e.g., after successful PATCH).
  Future<void> removePendingChange(String todoId) async {
    await _pendingBox.delete(todoId);
  }

  /// Returns all pending changes.
  List<PendingTodoChange> getPendingChanges() {
    return _pendingBox.values.toList();
  }

  /// Returns the count of pending changes.
  int get pendingCount => _pendingBox.length;

  /// Syncs all pending changes to the backend.
  /// Returns true if all changes were synced successfully.
  Future<bool> syncPendingChanges() async {
    if (_pendingBox.isEmpty) return true;

    final dio = getIt<ApiHelper>().dio;
    final entries = _pendingBox.toMap().entries.toList();
    bool allSynced = true;

    for (final entry in entries) {
      final change = entry.value;
      try {
        final response = await dio.patch(
          ApiEndpoints.patchTodo(change.todoId),
          data: {
            'is_completed': change.isCompleted,
            "updated_at": change.changedAt,
          },
          options: Options(extra: {'requiresAuth': true}),
        );

        if (response.statusCode != null &&
            response.statusCode! >= 200 &&
            response.statusCode! < 300) {
          await _pendingBox.delete(entry.key);
          debugPrint('✅ Synced todo: ${change.todoId}');
        } else {
          allSynced = false;
          debugPrint('❌ Failed to sync todo: ${change.todoId}');
        }
      } catch (e) {
        allSynced = false;
        debugPrint('❌ Error syncing todo ${change.todoId}: $e');
      }
    }

    if (allSynced || _pendingBox.isEmpty) {
      await _updateLastSyncTime();
    }

    return allSynced;
  }

  /// Batch syncs all pending changes to the backend via POST /api/v1/todos/sync.
  /// Sends all changes in a single request.
  /// Returns true if sync was successful.
  Future<bool> batchSyncPendingChanges() async {
    if (_pendingBox.isEmpty) return true;

    final dio = getIt<ApiHelper>().dio;
    final changes = _pendingBox.values.map((change) {
      return {
        'todo_id': change.todoId,
        'is_completed': change.isCompleted,
        'updated_at': change.changedAt.toUtc().toIso8601String(),
      };
    }).toList();

    try {
      final response = await dio.post(
        ApiEndpoints.syncTodos,
        data: {'changes': changes},
        options: Options(extra: {'requiresAuth': true}),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        await _pendingBox.clear();
        await _updateLastSyncTime();
        debugPrint('✅ Batch synced ${changes.length} changes');
        return true;
      } else {
        debugPrint('❌ Batch sync failed: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      debugPrint('❌ Batch sync error: $e');
      return false;
    }
  }

  /// Gets the last sync time as a formatted string.
  String? getLastSyncTime() {
    final timestamp = _metaBox.get(_lastSyncKey);
    if (timestamp == null) return null;
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute $period';
  }

  Future<void> _updateLastSyncTime() async {
    await _metaBox.put(_lastSyncKey, DateTime.now().millisecondsSinceEpoch);
  }
}
