class NavigationState {
  final int currentTabIndex;

  NavigationState({required this.currentTabIndex});

  NavigationState.initial() : this(currentTabIndex: 0);

  NavigationState copyWith({required int currentTab}) {
    return NavigationState(currentTabIndex: currentTab);
  }
}
