import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/signup_controller.dart';
import '../../../../utils/reusable_widget/app_text_field.dart';
import '../../../../utils/reusable_widget/app_button.dart';
import '../../../../utils/reusable_widget/google_signin_button.dart';
import '../../../../utils/app_sizes.dart';
import '../../../../themes/app_themes.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

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
                
                SizedBox(height: AppCommonSizes.paddingXL),
                
                // Name field
                AppTextField(
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                  controller: controller.nameController,
                  validator: controller.validateName,
                  prefixIcon: const Icon(Icons.person_outline),
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                ),
                
                SizedBox(height: AppCommonSizes.paddingL),
                
                // Email field
                AppTextFieldVariants.email(
                  labelText: 'Email Address',
                  controller: controller.emailController,
                  validator: controller.validateEmail,
                ),
                
                SizedBox(height: AppCommonSizes.paddingL),
                
                // Password field
                AppTextField(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  controller: controller.passwordController,
                  validator: controller.validatePassword,
                  obscureText: true,
                  prefixIcon: const Icon(Icons.lock_outline),
                  textInputAction: TextInputAction.next,
                ),
                
                SizedBox(height: AppCommonSizes.paddingL),
                
                // Confirm Password field
                AppTextField(
                  labelText: 'Confirm Password',
                  hintText: 'Confirm your password',
                  controller: controller.confirmPasswordController,
                  validator: controller.validateConfirmPassword,
                  obscureText: true,
                  prefixIcon: const Icon(Icons.lock_outline),
                  textInputAction: TextInputAction.done,
                ),
                
                SizedBox(height: AppCommonSizes.paddingS),
                
                // Terms and conditions checkbox
                _buildTermsCheckbox(),
                
                SizedBox(height: AppCommonSizes.paddingM),
                
                // Signup button
                Obx(() => AppButtonVariants.submit(
                  text: 'Create Account',
                  onPressed: controller.isLoading ? null : controller.signup,
                  isLoading: controller.isLoading,
                )),
                
                SizedBox(height: AppCommonSizes.paddingM),
                
                // Divider with "OR"
                _buildDivider(),
                
                SizedBox(height: AppCommonSizes.paddingM),
                
                // Google Sign-Up button
                Obx(() => GoogleSignInButtonVariants.signup(
                  onPressed: controller.isLoading ? null : controller.signUpWithGoogle,
                  isLoading: controller.isLoading,
                )),
                
                SizedBox(height: AppCommonSizes.paddingXL),
                
                // Login link
                _buildLoginLink(),
                
                SizedBox(height: AppCommonSizes.paddingL),
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
          'Create Account',
          textAlign: TextAlign.center,
          style: Get.theme.textTheme.headlineLarge?.copyWith(
            color: AppThemes.lightPrimaryTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
        
        SizedBox(height: AppCommonSizes.paddingXS),
        
        Text(
          'Join Bhatar Fasal to start your farming journey',
          textAlign: TextAlign.center,
          style: Get.theme.textTheme.bodyMedium?.copyWith(
            color: AppThemes.lightSecondaryTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => Checkbox(
          value: controller.acceptTerms,
          onChanged: controller.toggleAcceptTerms,
          activeColor: AppThemes.primaryColor,
        )),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: AppCommonSizes.paddingS),
            child: Row(
              children: [
                Text(
                  'I agree to the ',
                  style: Get.theme.textTheme.bodyMedium?.copyWith(
                    color: AppThemes.lightSecondaryTextColor,
                  ),
                ),
                GestureDetector(
                  onTap: controller.goToTermsAndConditions,
                  child: Text(
                    'Terms and Conditions',
                    style: Get.theme.textTheme.bodyMedium?.copyWith(
                      color: AppThemes.primaryColor,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
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

  Widget _buildLoginLink() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already have an account? ',
            style: Get.theme.textTheme.bodyMedium?.copyWith(
              color: AppThemes.lightSecondaryTextColor,
            ),
          ),
          TextButton(
            onPressed: controller.goToLogin,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Sign In',
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