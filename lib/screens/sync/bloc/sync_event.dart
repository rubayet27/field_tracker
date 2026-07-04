abstract class SyncEvent {}

class LoadSyncStatus extends SyncEvent {}

class ConnectivityChanged extends SyncEvent {
  final bool isOnline;
  ConnectivityChanged({required this.isOnline});
}

class SyncCompleted extends SyncEvent {}

class ManualSync extends SyncEvent {}

class BatchSync extends SyncEvent {}
