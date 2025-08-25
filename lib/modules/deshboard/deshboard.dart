import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mmherbel/modules/deshboard/home.dart';
import 'package:mmherbel/modules/deshboard/notificatoin.dart';
import 'package:mmherbel/modules/deshboard/product.dart';
import 'package:mmherbel/modules/deshboard/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:mmherbel/modules/deshboard/wishlist.dart';
import 'package:mmherbel/theme/app_colors.dart';
import 'package:mmherbel/modules/deshboard/controllers/dashboard_controller.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  Future<bool> _onWillPop(BuildContext context) async {
    return await showCupertinoDialog<bool>(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text(
              "Exit App",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text("Are you sure you want to exit the app?"),
            ),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Cancel"),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Exit"),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.put(DashboardController());

    final pages = [
      const HomePage(),
      const Product(),
      const NotificationPage(),
      const WishlistPage(),
      const Profile()
    ];

    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Obx(
        () => Scaffold(
          body: pages[controller.tabIndex.value],
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(
                height: 1,
                thickness: 0.8,
                color: Colors.grey.shade400,
              ),
              Theme(
                data: Theme.of(context).copyWith(
                  splashFactory: NoSplash.splashFactory,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                ),
                child: SizedBox(
                  height: 80.h,
                  child: BottomNavigationBar(
                    backgroundColor: Colors.white,
                    type: BottomNavigationBarType.fixed,
                    currentIndex: controller.tabIndex.value,
                    onTap: controller.changeTab,
                    selectedItemColor: Colors.black,
                    unselectedItemColor: Colors.black.withAlpha(180),
                    showUnselectedLabels: true,
                    selectedLabelStyle: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                    ),
                    items: [
                      _buildNavItem(
                        Icons.home,
                        Icons.home_outlined,
                        'Home',
                        0,
                        controller,
                      ),
                      _buildNavItem(
                        Icons.storefront,
                        Icons.storefront_outlined,
                        'Products',
                        1,
                        controller,
                      ),
                      _buildNavItem(
                        Icons.notifications,
                        Icons.notifications_outlined,
                        'Notifications',
                        2,
                        controller,
                      ),
                      _buildNavItem(
                        Icons.favorite,
                        Icons.favorite_border,
                        'Wishlist',
                        3,
                        controller,
                      ),
                      _buildNavItem(
                        Icons.person,
                        Icons.person_outline,
                        'Profile',
                        4,
                        controller,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
    IconData filledIcon,
    IconData outlinedIcon,
    String label,
    int index,
    DashboardController controller,
  ) {
    bool isActive = controller.tabIndex.value == index;
    Color activeIconColor = AppsColors.primary;
    Color inactiveIconColor = Colors.black87;

    return BottomNavigationBarItem(
      icon: Container(
        margin: EdgeInsets.symmetric(
          vertical: 4.h,
        ),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: isActive
              ? activeIconColor.withAlpha((0.2 * 255).toInt())
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Icon(
          isActive ? filledIcon : outlinedIcon,
          color: isActive ? activeIconColor : inactiveIconColor,
          size: 24.sp,
        ),
      ),
      label: label,
    );
  }
}
