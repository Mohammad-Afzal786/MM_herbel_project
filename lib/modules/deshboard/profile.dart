import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mmherbel/theme/app_colors.dart';
import 'package:mmherbel/modules/deshboard/controllers/dashboard_controller.dart';
import 'package:mmherbel/core/utils/nav_helper.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.find<DashboardController>();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          controller.changeTab(0); // ✅ Home tab पर switch
        }
      },

      child: Scaffold(
        backgroundColor: AppsColors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(CupertinoIcons.back),
            color: Colors.black,
            onPressed: () {
              controller.changeTab(0); // ✅ back arrow → Home
            },
          ),
          title: Text(
            "Profile",
            style: TextStyle(fontSize: 18.sp),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 20.h),

                /// 🧑 Profile Avatar
                CircleAvatar(
                  radius: 45.r,
                  backgroundImage: const AssetImage('assets/images/img.png'),
                ),
                SizedBox(height: 10.h),

                /// 🏷️ Info Card
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    Text(
                      "Kashif Khan",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),

                    Text(
                      "kashifkhan786@gmail.com",
                      style: TextStyle(fontSize: 13.sp, color: Colors.black87),
                    ),
                    SizedBox(height: 4.h),

                    GestureDetector(
                      onTap: () {
                        NavHelper.goToEditProfile();
                      },
                      child: Container(
                        width: 200.h,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: AppsColors.primary.withAlpha(
                            (0.2 * 255).toInt(),
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Icon(
                              Icons.edit,
                              size: 18.sp,
                              color: AppsColors.primary,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              "Edit Profile",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppsColors.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// Name + Edit button
                  ],
                ),

                SizedBox(height: 30.h),

                /// 🔽 Other Options
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildListTile(Icons.receipt_long, "My orders"),
                    _buildListTile(
                      Icons.medical_services_outlined,
                      "Consultation History",
                    ),
                    _buildListTile(
                      Icons.favorite_border,
                      "Saved Hakeem nuskhe",
                    ),
                    _buildListTile(Icons.delivery_dining, "Delivery Address"),
                    _buildListTile(Icons.support_agent, "Support & Help"),
                    _buildListTile(Icons.info_outline, "About Us"),
                    _buildListTile(Icons.settings, "Settings"),
                    _buildListTile(Icons.logout, "Logout"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
      leading: Icon(icon, color: Colors.black87, size: 22.sp),
      title: Text(title, style: TextStyle(fontSize: 14.sp)),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 14.sp,
        color: Colors.black26,
      ),
      onTap: () {},
      splashColor: Colors.grey.shade200,
      hoverColor: Colors.grey.shade100,
    );
  }
}
