part of 'navigation_screen.dart';

class NavigationPhoneScreen extends StatelessWidget {
  NavigationPhoneScreen({super.key});

  final List<Widget> tabScreens = [
    TaskScreen(),
    LocationScreen(),
    SyncScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: tabScreens[state.currentTabIndex],
          bottomNavigationBar: NavbarWidget(),
        );
      },
    );
  }
}
