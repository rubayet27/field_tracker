import 'package:flutter/material.dart';
import '../../location/model/location_model.dart';
import 'edit_location_phone_screen.dart';
import '../../../utils/layout_manager.dart';

class EditLocationScreen extends StatelessWidget {
  final Datum location;
  const EditLocationScreen({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return const LayoutManager(
      phoneLayout: EditLocationPhoneScreen(),
    );
  }
}
