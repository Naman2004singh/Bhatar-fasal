import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../routes/route_name.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  // Text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Form key for validation
  final formKey = GlobalKey<FormState>();

  // Observable variables
  final RxBool _isLoading = false.obs;
  final RxBool _obscurePassword = true.obs;
  final RxBool _rememberMe = false.obs;

  // Getters
  bool get isLoading => _isLoading.value;
  bool get obscurePassword => _obscurePassword.value;
  bool get rememberMe => _rememberMe.value;

  @override
  void onInit() {
    super.onInit();
    _loadRememberedCredentials();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  /// Toggle password visibility
  void togglePasswordVisibility() {
    _obscurePassword.value = !_obscurePassword.value;
  }

  /// Toggle remember me
  void toggleRememberMe(bool? value) {
    _rememberMe.value = value ?? false;
  }

  /// Validate email format
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    
    return null;
  }

  /// Validate password
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    
    return null;
  }

  /// Handle login submission
  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      _setLoading(true);

      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Replace with actual authentication logic
      final email = emailController.text.trim();
      final password = passwordController.text;

      // Simple demo login (replace with real authentication)
      if (email.isNotEmpty && password.length >= 6) {
        // Save login status
        await _saveLoginStatus(true);
        
        // Save credentials if remember me is checked
        if (rememberMe) {
          await _saveCredentials(email, password);
        }

        // Show success message
        Get.snackbar(
          'Success',
          'Login successful!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );

        // Navigate to home
        Get.offAllNamed(RouteName.HOME);
      } else {
        _showErrorMessage('Invalid email or password');
      }
    } catch (e) {
      _showErrorMessage('Login failed. Please try again.');
    } finally {
      _setLoading(false);
    }
  }

  /// Handle Google Sign-In
  Future<void> signInWithGoogle() async {
    try {
      _setLoading(true);

      // Simulate Google Sign-In API call
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Implement actual Google Sign-In
      Get.snackbar(
        'Info',
        'Google Sign-In will be implemented',
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      // For demo purposes, navigate to home
      await _saveLoginStatus(true);
      Get.offAllNamed(RouteName.HOME);
    } catch (e) {
      _showErrorMessage('Google Sign-In failed. Please try again.');
    } finally {
      _setLoading(false);
    }
  }

  /// Navigate to signup page
  void goToSignup() {
    Get.toNamed(RouteName.SIGNUP);
  }

  /// Navigate to forgot password page
  void goToForgotPassword() {
    // TODO: Implement forgot password navigation
    Get.snackbar(
      'Info',
      'Forgot password will be implemented',
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  /// Load remembered credentials
  Future<void> _loadRememberedCredentials() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final rememberedEmail = prefs.getString('remembered_email');
      final rememberedPassword = prefs.getString('remembered_password');
      
      if (rememberedEmail != null && rememberedPassword != null) {
        emailController.text = rememberedEmail;
        passwordController.text = rememberedPassword;
        _rememberMe.value = true;
      }
    } catch (e) {
      // Handle error silently
    }
  }

  /// Save credentials for remember me
  Future<void> _saveCredentials(String email, String password) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('remembered_email', email);
      await prefs.setString('remembered_password', password);
    } catch (e) {
      // Handle error silently
    }
  }

  /// Save login status
  Future<void> _saveLoginStatus(bool isLoggedIn) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLogin', isLoggedIn);
    } catch (e) {
      // Handle error silently
    }
  }

  /// Show error message
  void _showErrorMessage(String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }

  /// Set loading state
  void _setLoading(bool value) {
    _isLoading.value = value;
  }
}