import 'package:field_tracker/screens/sync/model/pending_todo_change.dart';

enum SyncStatus { initial, loaded, syncing, error }

class SyncState {
  final SyncStatus status;
  final List<PendingTodoChange> pendingChanges;
  final bool isOnline;
  final bool isSyncing;
  final String? lastSyncTime;

  SyncState({
    required this.status,
    required this.pendingChanges,
    required this.isOnline,
    required this.isSyncing,
    this.lastSyncTime,
  });

  factory SyncState.initial() {
    return SyncState(
      status: SyncStatus.initial,
      pendingChanges: const [],
      isOnline: true,
      isSyncing: false,
      lastSyncTime: null,
    );
  }

  SyncState copyWith({
    SyncStatus? status,
    List<PendingTodoChange>? pendingChanges,
    bool? isOnline,
    bool? isSyncing,
    String? lastSyncTime,
  }) {
    return SyncState(
      status: status ?? this.status,
      pendingChanges: pendingChanges ?? this.pendingChanges,
      isOnline: isOnline ?? this.isOnline,
      isSyncing: isSyncing ?? this.isSyncing,
      lastSyncTime: lastSyncTime ?? this.lastSyncTime,
    );
  }
}
