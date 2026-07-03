import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/add_location_bloc.dart';
import 'add_location_phone_screen.dart';
import '../../../utils/layout_manager.dart';

class AddLocationScreen extends StatelessWidget {
  const AddLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddLocationBloc(),
      child: const LayoutManager(
        phoneLayout: AddLocationPhoneScreen(),
      ),
    );
  }
}
