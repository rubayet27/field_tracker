abstract class NavigationEvent {}

class ChangeTab extends NavigationEvent {
  final int tabIndex;
  ChangeTab({required this.tabIndex});
}
