import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/splash_controller.dart';
import '../../../utils/app_sizes.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Obx(() => AnimatedOpacity(
          opacity: controller.logoOpacity,
          duration: const Duration(milliseconds: 1200),
          child: AnimatedScale(
            scale: controller.logoScale,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.elasticOut,
            child: Container(
              padding: EdgeInsets.all(AppSplashSizes.containerPadding),
              child: Image.asset(
                'assets/logos/logo_removeBg.png',
                width: AppSplashSizes.getLogoWidth(context),
                height: AppSplashSizes.getLogoHeight(context),
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.agriculture,
                    size: AppSplashSizes.getFallbackIconSize(context),
                    color: Colors.green.shade600,
                  );
                },
              ),
            ),
          ),
        )),
      ),
    );
  }
}