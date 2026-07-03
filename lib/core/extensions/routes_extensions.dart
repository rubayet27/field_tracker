

import '../../routes/routes_list.dart';

extension RoutesExtensions on String {
  void go({Object? extra}) {
    RoutesPages.router.goNamed(this, extra: extra);
  }

  Future<T?> push<T>({Object? extra}) {
    return RoutesPages.router.pushNamed<T>(this, extra: extra);
  }

  void replace({Object? extra}) {
    RoutesPages.router.replaceNamed(this, extra: extra);
  }
}
 