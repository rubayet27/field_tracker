import 'package:field_tracker/core/widgets/primary_app_bar.dart';
import 'package:field_tracker/core/widgets/text_widget.dart';
import 'package:field_tracker/utils/dimensions.dart';
import 'package:field_tracker/utils/layout_manager.dart';
import 'package:flutter/material.dart';

import '../../../utils/sizes/sizes.dart';
import '../features/offline_alert.dart';
import '../features/pending_card.dart';
import '../features/pending_info_card.dart';

part 'sync_phone_screen.dart';

class SyncScreen extends StatelessWidget {
  const SyncScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutManager(phoneLayout: SyncPhoneScreen());
  }
}
