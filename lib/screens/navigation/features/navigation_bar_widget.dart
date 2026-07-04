import 'package:field_tracker/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/navigation_bloc.dart';
import '../bloc/navigation_event.dart';
import '../bloc/navigation_state.dart';
import 'bottom_button.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 0,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      elevation: 8,
      height: 60,
      color: isDark ? AppColors.componentDark : AppColors.componentLight,
      surfaceTintColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<NavigationBloc, NavigationState>(
              builder: (context, state) {
                return BottomButton(
                  icon: Icons.format_list_bulleted,
                  label: "Tasks",
                  isSelected: state.currentTabIndex == 0,
                  onTap: () {
                    context.read<NavigationBloc>().add(ChangeTab(tabIndex: 0));
                  },
                );
              },
            ),
            BlocBuilder<NavigationBloc, NavigationState>(
              builder: (context, state) {
                return BottomButton(
                  icon: Icons.place_outlined,
                  label: "Locations",
                  isSelected: state.currentTabIndex == 1,
                  onTap: () => {
                    context.read<NavigationBloc>().add(ChangeTab(tabIndex: 1)),
                  },
                );
              },
            ),
            BlocBuilder<NavigationBloc, NavigationState>(
              builder: (context, state) {
                return BottomButton(
                  icon: Icons.sync,
                  label: "Sync",
                  isSelected: state.currentTabIndex == 2,
                  onTap: () => {
                    context.read<NavigationBloc>().add(ChangeTab(tabIndex: 2)),
                  },
                );
              },
            ),

            BlocBuilder<NavigationBloc, NavigationState>(
              builder: (context, state) {
                return BottomButton(
                  icon: Icons.person_outline_outlined,
                  label: "Profile",
                  isSelected: state.currentTabIndex == 3,
                  onTap: () => {
                    context.read<NavigationBloc>().add(ChangeTab(tabIndex: 3)),
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
