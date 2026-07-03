import 'package:bloc/bloc.dart';
import 'package:field_tracker/core/api%20base/api_endpoint/api_endpoints.dart';
import 'package:field_tracker/core/api%20base/api_request/api_call.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import '../model/add_location_model.dart';
import 'add_location_event.dart';
import 'add_location_state.dart';

class AddLocationBloc extends Bloc<AddLocationEvent, AddLocationState> {
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  AddLocationBloc() : super(const AddLocationState()) {
    on<GetCurrentLocationEvent>(_onGetCurrentLocation);
    on<UpdateGeofenceDetailsEvent>(_onUpdateGeofenceDetails);
    on<SaveLocationEvent>(_onSaveLocation);
    on<ShowGeofenceNotificationEvent>(_onShowGeofenceNotification);

    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _localNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _onGetCurrentLocation(
    GetCurrentLocationEvent event,
    Emitter<AddLocationState> emit,
  ) async {
    emit(state.copyWith(isLoading: false, message: null));

    try {
      // 1. Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(
          state.copyWith(
            isLoading: false,
            message: 'Location services are disabled. Please enable GPS.',
          ),
        );
        return;
      }

      // 2. Check location permission status
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(
            state.copyWith(
              isLoading: false,
              message: 'Location permission was denied.',
            ),
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(
          state.copyWith(
            isLoading: false,
            message:
                'Location permissions are permanently denied. Please enable them in app settings.',
          ),
        );
        return;
      }

      // 3. Permission is granted (either whileInUse or always), get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      emit(
        state.copyWith(
          isLoading: false,
          latitude: position.latitude,
          longitude: position.longitude,
          message: 'Current location fetched successfully!',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(isLoading: false, message: 'Failed to get location: $e'),
      );
    }
  }

  void _onUpdateGeofenceDetails(
    UpdateGeofenceDetailsEvent event,
    Emitter<AddLocationState> emit,
  ) {
    emit(
      state.copyWith(
        latitude: event.latitude ?? state.latitude,
        longitude: event.longitude ?? state.longitude,
        radius: event.radius ?? state.radius,
        locationName: event.locationName ?? state.locationName,
        message: null,
      ),
    );
  }

  Future<void> _onSaveLocation(
    SaveLocationEvent event,
    Emitter<AddLocationState> emit,
  ) async {
    if (state.locationName.trim().isEmpty) {
      emit(state.copyWith(message: 'Please enter a location name.'));
      return;
    }
    if (state.latitude == null || state.longitude == null) {
      emit(state.copyWith(message: 'Please fetch current location first.'));
      return;
    }

    emit(state.copyWith(isLoading: true, message: null));

    await ApiCall.call<AddLocationModel>(
      path: ApiEndpoints.addLocation,
      method: ApiMethodType.post,
      data: {
        "location_name": state.locationName,
        "latitude": state.latitude,
        "longitude": state.longitude,
        "radius_m": state.radius,
      },
      fromJson: AddLocationModel.fromJson,
      onSuccess: (value) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
            message: 'Location saved successfully!',
          ),
        );
      },
      isLoading: (isLoading) {},
    );

    // Automatically trigger notification on successful save to demonstrate the function
    add(const ShowGeofenceNotificationEvent());
  }

  Future<void> _onShowGeofenceNotification(
    ShowGeofenceNotificationEvent event,
    Emitter<AddLocationState> emit,
  ) async {
    // Request notification permission if required (primarily for Android 13+)
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }

    await showGeofenceNotification();
  }

  Future<void> showGeofenceNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'geofence_channel_id',
          'Geofence Notifications',
          channelDescription: 'Notification when entering geofence region',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await _localNotificationsPlugin.show(
      0,
      'Geofence Alert',
      'You have entered the selected location.',
      platformChannelSpecifics,
    );
  }
}
