import 'package:get/get.dart';
import 'route_name.dart';

// Import modules
import '../modules/spalsh/binding/splash_binding.dart';
import '../modules/spalsh/view/splash_view.dart';

// Import other modules
import '../modules/home/binding/home_binding.dart';
import '../modules/home/view/home_view.dart';

// Import authentication modules
import '../modules/authentication/login/binding/login_binding.dart';
import '../modules/authentication/login/view/login_view.dart';
import '../modules/authentication/signup/binding/signup_binding.dart';
import '../modules/authentication/signup/view/signup_view.dart';

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

    // Authentication Routes
    GetPage(
      name: RouteName.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: RouteName.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
      transition: Transition.rightToLeft,
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
