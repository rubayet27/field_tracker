import 'dart:async';

import 'package:field_tracker/core/api%20base/api_helper/api_helper.dart';
import 'package:field_tracker/screens/sync/bloc/sync_event.dart';
import 'package:field_tracker/screens/sync/bloc/sync_state.dart';
import 'package:field_tracker/screens/sync/service/connectivity_service.dart';
import 'package:field_tracker/screens/sync/service/todo_sync_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SyncBloc extends Bloc<SyncEvent, SyncState> {
  final TodoSyncService _syncService = getIt<TodoSyncService>();
  final ConnectivityService _connectivityService = getIt<ConnectivityService>();
  StreamSubscription<bool>? _connectivitySubscription;

  SyncBloc() : super(SyncState.initial()) {
    on<LoadSyncStatus>(_loadSyncStatus);
    on<ConnectivityChanged>(_connectivityChanged);
    on<SyncCompleted>(_syncCompleted);
    on<ManualSync>(_manualSync);
    on<BatchSync>(_batchSync);

    // Listen for connectivity changes
    _connectivitySubscription = _connectivityService.onlineStream.listen((
      isOnline,
    ) {
      add(ConnectivityChanged(isOnline: isOnline));
      if (isOnline && _syncService.pendingCount > 0) {
        add(ManualSync());
      }
    });
  }

  void _loadSyncStatus(LoadSyncStatus event, Emitter<SyncState> emit) {
    final pending = _syncService.getPendingChanges();
    final lastSync = _syncService.getLastSyncTime();
    emit(
      state.copyWith(
        status: SyncStatus.loaded,
        pendingChanges: pending,
        isOnline: _connectivityService.isOnline,
        lastSyncTime: lastSync,
      ),
    );
  }

  void _connectivityChanged(
    ConnectivityChanged event,
    Emitter<SyncState> emit,
  ) {
    emit(state.copyWith(isOnline: event.isOnline));
  }

  Future<void> _syncCompleted(
    SyncCompleted event,
    Emitter<SyncState> emit,
  ) async {
    final pending = _syncService.getPendingChanges();
    final lastSync = _syncService.getLastSyncTime();
    emit(
      state.copyWith(
        status: SyncStatus.loaded,
        pendingChanges: pending,
        isSyncing: false,
        lastSyncTime: lastSync,
      ),
    );
  }

  Future<void> _manualSync(ManualSync event, Emitter<SyncState> emit) async {
    if (state.isSyncing) return;
    if (!_connectivityService.isOnline) return;
    if (_syncService.pendingCount == 0) return;

    emit(state.copyWith(isSyncing: true, status: SyncStatus.syncing));

    try {
      await _syncService.syncPendingChanges();
    } catch (e) {
      debugPrint('❌ Sync error: $e');
    }

    final pending = _syncService.getPendingChanges();
    final lastSync = _syncService.getLastSyncTime();
    emit(
      state.copyWith(
        status: SyncStatus.loaded,
        pendingChanges: pending,
        isSyncing: false,
        lastSyncTime: lastSync,
      ),
    );
  }

  Future<void> _batchSync(BatchSync event, Emitter<SyncState> emit) async {
    if (state.isSyncing) return;
    if (_syncService.pendingCount == 0) return;

    emit(state.copyWith(isSyncing: true, status: SyncStatus.syncing));

    try {
      await _syncService.batchSyncPendingChanges();
    } catch (e) {
      debugPrint('❌ Batch sync error: $e');
    }

    final pending = _syncService.getPendingChanges();
    final lastSync = _syncService.getLastSyncTime();
    emit(
      state.copyWith(
        status: SyncStatus.loaded,
        pendingChanges: pending,
        isSyncing: false,
        lastSyncTime: lastSync,
      ),
    );
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
