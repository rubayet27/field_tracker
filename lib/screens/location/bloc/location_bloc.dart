import 'package:field_tracker/core/api%20base/api_endpoint/api_endpoints.dart';
import 'package:field_tracker/screens/location/bloc/location_event.dart';
import 'package:field_tracker/screens/location/bloc/location_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/api base/api_request/api_call.dart';
import '../model/location_model.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationState.initial()) {
    on<GetAllLocation>(_getAllLocation);
  }

  Future<void> _getAllLocation(
    GetAllLocation event,
    Emitter<LocationState> emit,
  ) async {
    emit(state.copyWith(status: LocationStatus.loading));
    await ApiCall.call(
      path: ApiEndpoints.getLocations,
      method: ApiMethodType.get,
      fromJson: LocationModel.fromJson,
      onSuccess: (value) {
        emit(state.copyWith(status: LocationStatus.success, data: value.data));
      },
      isLoading: (loading) {},
    );
  }
}
