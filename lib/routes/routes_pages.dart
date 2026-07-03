part of 'routes_list.dart';

class RoutesPages {
  static final GoRouter router = GoRouter(
    initialLocation: '/${Routes.splash}',
    routes: [
      GoRoute(
        name: Routes.home,
        path: '/${Routes.home}',
        builder: (_, _) => HomeScreen(),
      ),

      GoRoute(
        name: Routes.splash,
        path: '/${Routes.splash}',
        builder: (_, _) {
          return BlocProvider(
            create: (_) => SplashBloc()..add(SplashRoute()),
            child: SplashScreen(),
          );
        },
      ),

      GoRoute(
        name: Routes.login,
        path: '/${Routes.login}',
        builder: (_, _) {
          return BlocProvider(create: (_) => LoginBloc(), child: LoginScreen());
        },
      ),
      GoRoute(
        name: Routes.registration,
        path: '/${Routes.registration}',
        builder: (_, _) {
          return RegistrationScreen();
        },
      ),
      GoRoute(
        name: Routes.navigation,
        path: '/${Routes.navigation}',
        builder: (_, _) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => NavigationBloc()),
              BlocProvider(create: (_) => ProfileBloc()..add(GetUserInfo())),
              BlocProvider(
                create: (_) => LocationBloc()..add(GetAllLocation()),
              ),
              BlocProvider(create: (_) => TaskBloc()..add(GetTodos())),
            ],
            child: NavigationScreen(),
          );
        },
      ),

      GoRoute(
        name: Routes.addLocation,
        path: '/${Routes.addLocation}',
        builder: (_, _) {
          return BlocProvider(
            create: (_) => AddLocationBloc(),
            child: AddLocationScreen(),
          );
        },
      ),
      GoRoute(
        name: Routes.editLocation,
        path: '/${Routes.editLocation}',
        builder: (_, state) {
          final datum = state.extra as Datum;
          return BlocProvider(
            create: (_) => EditLocationBloc(location: datum),
            child: EditLocationScreen(location: datum),
          );
        },
      ),

      // for bloc bindings

      // GoRoute(
      //   name: Routes.home,
      //   path: "/${Routes.home}",
      //   builder: (context, state) {
      //     return MultiBlocProvider(
      //       providers: [
      //         BlocProvider(create: (_) => HomeBloc()),
      //         BlocProvider(create: (_) => BannerBloc()),
      //       ],
      //       child: const HomePage(),
      //     );
      //   },
      // ),
    ],
  );
}
