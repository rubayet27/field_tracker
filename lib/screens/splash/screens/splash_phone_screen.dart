part of 'splash_screen.dart';

class SplashPhoneScreen extends StatelessWidget {
  const SplashPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocListener<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state.status == SplashStatus.authenticated) {
              Routes.navigation.go();
            } else {
              Routes.login.go();
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [BrandLogo()],
          ),
        ),
      ),
    );
  }
}
