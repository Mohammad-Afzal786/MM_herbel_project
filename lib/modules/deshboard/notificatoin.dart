import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mmherbel/theme/app_colors.dart';
import 'package:mmherbel/modules/deshboard/controllers/dashboard_controller.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.find<DashboardController>();

    final List<String> notifications = [
      "🎉 Your order #1234 has been shipped.",
      "🔥 New offer: 50% off on selected items.",
      "📦 Your package will be delivered tomorrow.",
      "❤️ Someone liked your wishlist item.",
      "🚚 Your order is out for delivery.",
      "💸 You've received a refund of 10.",
      "🎁 A gift has been added to your wishlist.",
      "🔔 Your subscription will renew in 3 days.",
      "📱 New update available for your app!",
      "⭐ You earned a new reward point!",
      "💬 New message from customer support.",
      "🛒 Items in your cart are on sale!",
      "👀 Someone viewed your profile.",
      "🔥 Flash sale live! Grab it before it's gone.",
      "📅 Reminder: Your appointment is tomorrow.",
      "📍 Your package has arrived at the nearest store.",
    ];

     return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          controller.changeTab(0); // ✅ Home tab पर switch
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white, // Global white background
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(CupertinoIcons.back),
            color: Colors.black,
            onPressed: () {
              controller.changeTab(0); // Home tab when back is pressed
            },
          ),
          title: Text(
            "Notification",
            style: TextStyle(
              fontSize: 18.sp, // Scaled font size using ScreenUtil
              
            ),
          ),
          centerTitle: true,
          foregroundColor: Colors.black,
        ),

        body: notifications.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/bell.png',
                      width: 120.w,
                      height: 120.w,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      "No Notification yet",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppsColors.primary,
                        padding: EdgeInsets.symmetric(
                          vertical: 12.h,
                          horizontal: 32.w,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                      ),
                      onPressed: () {
                        // Button functionality
                      },
                      child: Text(
                        "Explore Categories",
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  return Dismissible(
  key: UniqueKey(),
  direction: DismissDirection.endToStart,
  background: Container(
    alignment: Alignment.centerRight,
    padding: EdgeInsets.symmetric(horizontal: 24.w),
    color: AppsColors.primary,
    child: Icon(Icons.delete, color: Colors.white, size: 28.sp),
  ),
  onDismissed: (direction) {
    notifications.removeAt(index);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Notification deleted'),
        duration: Duration(seconds: 1),
      ),
    );
  },
  child: ClipRRect(
    borderRadius: BorderRadius.circular(12.r), // same radius as card
    child: Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        // Remove borderRadius here since ClipRRect handles it
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4.r,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(Icons.notifications, color: Colors.blue, size: 24.sp),
        title: Text(
          notifications[index],
          style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
        ),
        subtitle: Text("Just now", style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
        contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        onTap: () {},
      ),
    ),
  ),
);

                },
              ),
      ),
    );
  }
}
