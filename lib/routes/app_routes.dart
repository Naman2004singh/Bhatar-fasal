import 'package:get/get.dart';
import 'route_name.dart';

// Import modules
import '../modules/spalsh/binding/splash_binding.dart';
import '../modules/spalsh/view/splash_view.dart';

// Import other modules (you'll need to create these)
import '../modules/home/binding/home_binding.dart';
import '../modules/home/view/home_view.dart';

class AppRoutes {
  static List<GetPage> routes = [
    // Splash Screen
    GetPage(
      name: RouteName.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // Home Screen
    GetPage(
      name: RouteName.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // Main Screen (if needed)
    GetPage(
      name: RouteName.MAIN,
      page: () => const HomeView(), // For now, redirect to home
      binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
  ];

  /// Get initial route
  static String get initialRoute => RouteName.SPLASH;
}
