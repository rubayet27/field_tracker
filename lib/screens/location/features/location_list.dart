import 'package:field_tracker/screens/location/features/location_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/location_bloc.dart';
import '../bloc/location_state.dart';
import '../model/location_model.dart';

class LocationList extends StatelessWidget {
  const LocationList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.data!.length,
          itemBuilder: (context, index) {
            Datum location = state.data![index];
            return LocationCard(location: location);
          },
        );
      },
    );
  }
}
