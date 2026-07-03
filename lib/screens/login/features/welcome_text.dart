import 'package:flutter/widgets.dart';

import '../../../core/widgets/text_widget.dart';
import '../../../utils/dimensions.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWidget(
          "Welcome Back",
          style: TextStyle(
            fontSize: Dimensions.headlineSmall,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextWidget(
          "Sign in to start your shift",
          style: TextStyle(
            fontSize: Dimensions.bodyMedium,
            // fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
