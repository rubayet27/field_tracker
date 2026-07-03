part of 'home_screen.dart';

class HomePhoneScreen extends StatelessWidget {
  const HomePhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber,
        body: Column(
          children: [
            Padding(
              padding:
                  Sizes.padding.h(Dimensions.defaultPaddingSize) +
                  Sizes.padding.v(Dimensions.defaultPaddingSize),
              child: Container(
                height: 200.00.setHeight(),

                padding: Sizes.padding.p20,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Routes.splash.push();
                    },
                    child: Container(
                      height: 20.00.setHeight(),
                      width: 80.00.setWidth(),
                      color: Colors.green,
                      child: Text(
                        context
                            .watch<NavigationBloc>()
                            .state
                            .currentTabIndex
                            .toString(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
