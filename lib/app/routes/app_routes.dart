part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();
  static const splash = _Paths.splash;
  static const intro = _Paths.intro;
  static const home = _Paths.home;
  static const auth = _Paths.auth;
  static const appTour = _Paths.appRoute;

  static const pageNotFound = _Paths.pageNotFound;
  static String loginThen(String afterSuccessfulLogin) =>
      '$auth?then=${Uri.encodeQueryComponent(afterSuccessfulLogin)}';
  static const product = _Paths.home + _Paths.product;
  static const account = _Paths.home + _Paths.account;
  static const autionDetail = _Paths.home + _Paths.autionDetail;

  ///test routes
  static const DASHBOARD = _Paths.DASHBOARD;
  static const ECOM_DASHBOARD = _Paths.ECOM_DASHBOARD;
  static const CART = _Paths.CART;
}

abstract class _Paths {
  _Paths._();
  static const splash = '/splash';
  static const intro = '/intro';
  static const home = '/home';
  static const auth = '/auth';
  static const appRoute = '/app-tour';

  ///page not found
  static const pageNotFound = '/page-not-found';

  ///sub routes
  static const product = '/product';
  static const autionDetail = '/auction-detail';

  ///test routes
  static const DASHBOARD = '/dashboard';
  static const account = '/account';
  static const CART = '/cart';
  static const ECOM_DASHBOARD = '/ecom-dashboard';
}
