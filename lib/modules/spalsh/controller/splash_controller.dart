import 'dart:async';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../routes/route_name.dart';

class SplashController extends GetxController {
  static SplashController get instance => Get.find();

  // Observable variables
  final RxBool _isLoading = true.obs;
  final RxDouble _logoOpacity = 0.0.obs;
  final RxDouble _logoScale = 0.8.obs;

  // Getters
  bool get isLoading => _isLoading.value;
  double get logoOpacity => _logoOpacity.value;
  double get logoScale => _logoScale.value;

  @override
  void onInit() {
    super.onInit();
    _initializeSplash();
  }

  Future<void> _initializeSplash() async {
    try {
      await _animateLogo();
      
      await _checkLoginStatus();
      
      await Future.delayed(const Duration(seconds: 4));
      
      _setLoading(false);
    } catch (e) {
      _setLoading(false);
      _navigateToHome();
    }
  }

  Future<void> _animateLogo() async {
    _setLogoOpacity(1.0);
    
    await Future.delayed(const Duration(milliseconds: 800));
    _setLogoScale(1.0);
  }

  /// Check if user is already logged in
  Future<void> _checkLoginStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bool isLoggedIn = prefs.getBool('isLogin') ?? false;
      
      // Add a small delay to ensure smooth transition
      await Future.delayed(const Duration(milliseconds: 500));
      
      if (isLoggedIn) {
        _navigateToHome();
      } else {
        _navigateToHome(); // For now, navigate to home. Later you can add authentication route
      }
    } catch (e) {
      _navigateToHome();
    }
  }

  /// Navigate to home screen
  void _navigateToHome() {
    Get.offAllNamed(RouteName.HOME);
  }

  Future<bool> isLogin() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool('isLogin') ?? false;
    } catch (e) {
      return false;
    }
  }

  Future<void> setLoginStatus(bool status) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLogin', status);
    } catch (e) {
      // Handle error silently
    }
  }

  // Private setters for reactive variables
  void _setLoading(bool value) => _isLoading.value = value;
  void _setLogoOpacity(double value) => _logoOpacity.value = value;
  void _setLogoScale(double value) => _logoScale.value = value;

  @override
  void onClose() {
    // Clean up any resources if needed
    super.onClose();
  }
}