import 'package:flutter/material.dart';

import '../../../core/widgets/text_widget.dart';
import '../../../utils/dimensions.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWidget(
          "Create Your Account",
          style: TextStyle(
            fontSize: Dimensions.headlineSmall,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextWidget(
          "Join your team on FieldTrack",
          style: TextStyle(
            fontSize: Dimensions.bodyMedium,
            // fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
