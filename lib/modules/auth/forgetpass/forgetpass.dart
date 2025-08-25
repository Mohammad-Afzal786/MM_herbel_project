import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mmherbel/theme/app_colors.dart';
import 'package:mmherbel/core/utils/nav_helper.dart';

/// =============================================================
/// 🔑 ForgotPasswordScreen
/// =============================================================
/// Features:
/// - Logo (top left aligned)
/// - Title + Subtitle (start aligned)
/// - Email TextField (responsive)
/// - Continue Button
/// - Back button in AppBar → goes back to Login
/// =============================================================
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  /// Text controller for email input
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  /// 👉 Action when Continue button is pressed
  void onContinue() {
    String email = emailController.text.trim();
    if (email.isEmpty) {
      // Example: show snackbar
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please enter your email")));
    } else {
      // Here you can call your API for password reset
      debugPrint("Email entered: $email");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppsColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.back,
            color: Colors.black,
            size: 22.sp, // 👈 responsive size
          ),
          onPressed: () => NavHelper.backToLogin(),
        ),
        backgroundColor: AppsColors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// =============================================================
              /// 🖼️ Logo
              /// =============================================================
              SizedBox(
                height: 70.h,
                child: Image.asset(
                  'assets/images/logodesh.png',
                  width: 130.w,
                  height: 130.h,
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(height: 16.h),

              /// =============================================================
              /// 📝 Title & Subtitle
              /// =============================================================
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.sp,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                "Get help logging into your account.",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 14.sp, color: Colors.black54),
              ),
              SizedBox(height: 24.h),

              /// =============================================================
              /// 📧 Email TextField
              /// =============================================================
              Focus(
                child: Builder(
                  builder: (context) {
                    final hasFocus = Focus.of(context).hasFocus;

                    return TextField(
                      controller: emailController,
                      style: TextStyle(fontSize: 16.sp), // 👈 responsive text
                      decoration: InputDecoration(
                        labelText: "Email",

                        // ✅ Normal = grey, Focused = green
                        labelStyle: TextStyle(
                          fontSize: 14.sp,
                          color: hasFocus ? AppsColors.primary : Colors.grey,
                        ),

                        // ✅ Normal Border
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),

                        // ✅ Focused Border
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(
                            color: AppsColors.primary,
                            width: 2,
                          ),
                        ),

                        prefixIcon: Icon(
                          Icons.email_outlined,
                          size: 20.sp,
                          color: hasFocus
                              ? AppsColors.primary
                              : Colors.grey, // icon भी साथ में change
                        ),

                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.h,
                          horizontal: 12.w,
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 32.h),

              /// =============================================================
              /// 🔘 Continue Button
              /// =============================================================
              SizedBox(
                height: 48.h,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppsColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ),
                  onPressed: onContinue,
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
