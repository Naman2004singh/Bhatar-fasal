import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/login_controller.dart';
import '../../../../utils/reusable_widget/app_text_field.dart';
import '../../../../utils/reusable_widget/app_button.dart';
import '../../../../utils/reusable_widget/google_signin_button.dart';
import '../../../../utils/app_sizes.dart';
import '../../../../themes/app_themes.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemes.lightSecondaryBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppCommonSizes.paddingL),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header section
                _buildHeader(),
                
                SizedBox(height: AppCommonSizes.paddingXXL),
                
                // Email field
                AppTextFieldVariants.email(
                  labelText: 'Email Address',
                  controller: controller.emailController,
                  validator: controller.validateEmail,
                ),
                
                SizedBox(height: AppCommonSizes.paddingL),
                
                // Password field
                AppTextFieldVariants.password(
                  labelText: 'Password',
                  controller: controller.passwordController,
                  validator: controller.validatePassword,
                ),
                
                SizedBox(height: AppCommonSizes.paddingM),
                
                // Remember me and forgot password row
                _buildRememberMeRow(),
                
                SizedBox(height: AppCommonSizes.paddingL),
                
                // Login button
                Obx(() => AppButtonVariants.submit(
                  text: 'Sign In',
                  onPressed: controller.isLoading ? null : controller.login,
                  isLoading: controller.isLoading,
                )),
                
                SizedBox(height: AppCommonSizes.paddingM),
                
                // Divider with "OR"
                _buildDivider(),
                
                SizedBox(height: AppCommonSizes.paddingM),
                
                // Google Sign-In button
                Obx(() => GoogleSignInButtonVariants.login(
                  onPressed: controller.isLoading ? null : controller.signInWithGoogle,
                  isLoading: controller.isLoading,
                )),
                
                SizedBox(height: AppCommonSizes.paddingXXL),
                
                // Sign up link
                _buildSignupLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppCommonSizes.paddingM),
        
        // Welcome text
        Text(
          'Welcome Back!',
          textAlign: TextAlign.center,
          style: Get.theme.textTheme.headlineLarge?.copyWith(
            color: AppThemes.lightPrimaryTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
        
        SizedBox(height: AppCommonSizes.paddingS),
        
        Text(
          'Sign in to your account to continue',
          textAlign: TextAlign.center,
          style: Get.theme.textTheme.bodyLarge?.copyWith(
            color: AppThemes.lightSecondaryTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildRememberMeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Remember me checkbox
        Row(
          children: [
            Obx(() => Checkbox(
              value: controller.rememberMe,
              onChanged: controller.toggleRememberMe,
              activeColor: AppThemes.primaryColor,
            )),
            Text(
              'Remember me',
              style: Get.theme.textTheme.bodyMedium?.copyWith(
                color: AppThemes.lightSecondaryTextColor,
              ),
            ),
          ],
        ),
        
        // Forgot password link
        TextButton(
          onPressed: controller.goToForgotPassword,
          child: Text(
            'Forgot Password?',
            style: Get.theme.textTheme.bodyMedium?.copyWith(
              color: AppThemes.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: AppThemes.borderColor,
            thickness: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppCommonSizes.paddingM),
          child: Text(
            'OR',
            style: Get.theme.textTheme.bodyMedium?.copyWith(
              color: AppThemes.lightSecondaryTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: AppThemes.borderColor,
            thickness: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildSignupLink() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account? ",
            style: Get.theme.textTheme.bodyMedium?.copyWith(
              color: AppThemes.lightSecondaryTextColor,
            ),
          ),
          TextButton(
            onPressed: controller.goToSignup,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Sign Up',
              style: Get.theme.textTheme.bodyMedium?.copyWith(
                color: AppThemes.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}