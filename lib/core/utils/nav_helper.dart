import 'package:get/get.dart';
import 'package:mmherbel/config/routes.dart';
import 'package:mmherbel/modules/deshboard/controllers/dashboard_controller.dart';

class NavHelper {
  /// ======================
  /// 🚀 Auth Pages
  /// ======================
  static void goToLogin() {
    if (Get.currentRoute != AppRoutes.login) {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  static void backToLogin() {
    if (Get.previousRoute == AppRoutes.login) {
      Get.back();
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  /// ======================
  /// 🚀 Forgot Password
  /// ======================
  static void goToForgetPassword() {
    if (Get.currentRoute != AppRoutes.forgetPassword) {
      Get.toNamed(AppRoutes.forgetPassword);
    }
  }

  static void backToForgetPassword() {
    if (Get.previousRoute == AppRoutes.forgetPassword) {
      Get.back();
    } else {
      Get.offAllNamed(AppRoutes.forgetPassword);
    }
  }

  /// ======================
  /// 🚀 Edit Profile
  /// ======================
  static void goToEditProfile() {
    if (Get.currentRoute != AppRoutes.editProfile) {
      Get.toNamed(AppRoutes.editProfile);
    }
  }

  static void backToProfileFromEdit() {
    if (Get.currentRoute == AppRoutes.editProfile) {
      Get.back();
      final controller = Get.find<DashboardController>();
      controller.changeTab(4);
    } else {
      Get.offAllNamed(AppRoutes.dashboard);
      Future.delayed(const Duration(milliseconds: 100), () {
        final controller = Get.find<DashboardController>();
        controller.changeTab(4);
      });
    }
  }

  /// ======================
  /// 🚀 Create Account
  /// ======================
  static void goToCreateAccount() {
    if (Get.currentRoute != AppRoutes.createAccount) {
      Get.toNamed(AppRoutes.createAccount);
    }
  }

  static void backToCreateAccount() {
    if (Get.previousRoute == AppRoutes.createAccount) {
      Get.back();
    } else {
      Get.offAllNamed(AppRoutes.createAccount);
    }
  }

  /// ======================
  /// 🚀 Dashboard
  /// ======================
  static void goToDashboard() {
    if (Get.currentRoute != AppRoutes.dashboard) {
      Get.offAllNamed(AppRoutes.dashboard);
    }
  }

  /// 🚀 Switch Tabs Inside Dashboard
  static void goToHomeTab() => Get.find<DashboardController>().changeTab(0);
  static void goToProductsTab() => Get.find<DashboardController>().changeTab(1);
  static void goToNotificationTab() => Get.find<DashboardController>().changeTab(2);
  static void goToWishlistTab() => Get.find<DashboardController>().changeTab(3);
  static void goToProfileTab() => Get.find<DashboardController>().changeTab(4);
}
