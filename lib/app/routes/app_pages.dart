import 'package:get/get.dart';

import '../middleware/auth_middleware.dart';
import '../modules/appTour/bindings/app_tour_binding.dart';
import '../modules/appTour/views/app_tour_view.dart';
import '../modules/auction_detail/bindings/auction_detail_binding.dart';
import '../modules/auction_detail/views/auction_detail_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/auth/views/onboarding_view.dart';
import '../modules/auth/views/splash_view.dart';
import '../modules/ecom_app/view/cart/bindings/cart_binding.dart';
import '../modules/ecom_app/view/cart/views/cart_view.dart';
import '../modules/ecom_app/view/ecom_dashboard/bindings/ecom_dashboard_binding.dart';
import '../modules/ecom_app/view/ecom_dashboard/views/ecom_dashboard_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/product/bindings/product_binding.dart';
import '../modules/product/views/product_view.dart';
import '../modules/socialApp/view/account/bindings/account_binding.dart';
import '../modules/socialApp/view/account/views/account_view.dart';
import '../modules/socialApp/view/dashboard/bindings/dashboard_binding.dart';
import '../modules/socialApp/view/dashboard/views/dashboard_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: _Paths.splash,
      page: () => const SplashView(),
    ),
    GetPage(
      name: _Paths.intro,
      page: () => const OnboardingView(),
      middlewares: [
        EnsureNotAuthMiddleware(),
      ],
    ),

    // auth required routes
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      middlewares: [
        EnsureAuthMiddleware(),
      ],
      binding: HomeBinding(),
      children: [
        ///product
        GetPage(
          name: _Paths.product,
          page: () => const ProductView(),
          binding: ProductBinding(),
        ),

        ///auction
        GetPage(
          name: _Paths.autionDetail,
          page: () => const AuctionDetailView(),
          binding: AuctionDetailBinding(),
        ),

        ///profile
        GetPage(
          name: _Paths.account,
          page: () => AccountView(),
          binding: AccountBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.auth,
      page: () => const AuthView(),
      binding: AuthBinding(),
      middlewares: [
        EnsureNotAuthMiddleware(),
      ],
    ),
    GetPage(
      name: _Paths.appRoute,
      page: () => const AppTourView(),
      binding: AppTourBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.account,
      page: () => AccountView(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.ECOM_DASHBOARD,
      page: () => const EcomDashboardView(),
      binding: EcomDashboardBinding(),
    ),
  ];
}
