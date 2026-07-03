import 'package:field_tracker/core/widgets/text_widget.dart';
import 'package:field_tracker/screens/tasks/bloc/task_bloc.dart';
import 'package:field_tracker/screens/tasks/bloc/task_state.dart';
import 'package:field_tracker/screens/tasks/features/filter_chip.dart';
import 'package:field_tracker/utils/app_colors.dart';
import 'package:field_tracker/utils/dimensions.dart';
import 'package:field_tracker/utils/layout_manager.dart';
import 'package:field_tracker/utils/sizes/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/task_event.dart';
import '../features/progress_bar_widget.dart';
import '../features/task_card_widget.dart';

part 'task_phone_screen.dart';


class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutManager(phoneLayout:TaskPhoneScreen());
  }
}