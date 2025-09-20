import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../routes/route_name.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Text editing controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Form key for validation
  final formKey = GlobalKey<FormState>();

  // Observable variables
  final RxBool _isLoading = false.obs;
  final RxBool _obscurePassword = true.obs;
  final RxBool _obscureConfirmPassword = true.obs;
  final RxBool _acceptTerms = false.obs;

  // Getters
  bool get isLoading => _isLoading.value;
  bool get obscurePassword => _obscurePassword.value;
  bool get obscureConfirmPassword => _obscureConfirmPassword.value;
  bool get acceptTerms => _acceptTerms.value;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  /// Toggle password visibility
  void togglePasswordVisibility() {
    _obscurePassword.value = !_obscurePassword.value;
  }

  /// Toggle confirm password visibility
  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword.value = !_obscureConfirmPassword.value;
  }

  /// Toggle accept terms
  void toggleAcceptTerms(bool? value) {
    _acceptTerms.value = value ?? false;
  }

  /// Validate name
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }
    
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    
    return null;
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
    
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    
    // Check for at least one uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    
    // Check for at least one lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }
    
    // Check for at least one digit
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }
    
    return null;
  }

  /// Validate confirm password
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    
    return null;
  }

  /// Handle signup submission
  Future<void> signup() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (!acceptTerms) {
      _showErrorMessage('Please accept the terms and conditions');
      return;
    }

    try {
      _setLoading(true);

      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Replace with actual registration logic
      final name = nameController.text.trim();
      final email = emailController.text.trim();
      final password = passwordController.text;

      // Simple demo signup (replace with real authentication)
      if (name.isNotEmpty && email.isNotEmpty && password.length >= 8) {
        // Save user data and login status
        await _saveUserData(name, email);
        await _saveLoginStatus(true);

        // Show success message
        Get.snackbar(
          'Success',
          'Account created successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );

        // Navigate to home
        Get.offAllNamed(RouteName.HOME);
      } else {
        _showErrorMessage('Please fill all fields correctly');
      }
    } catch (e) {
      _showErrorMessage('Signup failed. Please try again.');
    } finally {
      _setLoading(false);
    }
  }

  /// Handle Google Sign-Up
  Future<void> signUpWithGoogle() async {
    try {
      _setLoading(true);

      // Simulate Google Sign-Up API call
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Implement actual Google Sign-Up
      Get.snackbar(
        'Info',
        'Google Sign-Up will be implemented',
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      // For demo purposes, navigate to home
      await _saveLoginStatus(true);
      Get.offAllNamed(RouteName.HOME);
    } catch (e) {
      _showErrorMessage('Google Sign-Up failed. Please try again.');
    } finally {
      _setLoading(false);
    }
  }

  /// Navigate to login page
  void goToLogin() {
    Get.back(); // Go back to login page
  }

  /// Navigate to terms and conditions
  void goToTermsAndConditions() {
    Get.snackbar(
      'Info',
      'Terms and Conditions will be implemented',
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  /// Save user data
  Future<void> _saveUserData(String name, String email) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', name);
      await prefs.setString('user_email', email);
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