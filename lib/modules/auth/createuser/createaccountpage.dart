import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mmherbel/theme/app_colors.dart';
import 'package:mmherbel/core/utils/nav_helper.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  bool agreeTerms = false;
  final TapGestureRecognizer _privacyRecognizer = TapGestureRecognizer();
  final TapGestureRecognizer _termsRecognizer = TapGestureRecognizer();

  @override
  void initState() {
    super.initState();
    _privacyRecognizer.onTap = () {
      Get.toNamed('/privacy');
    };
    _termsRecognizer.onTap = () {
      Get.toNamed('/terms');
    };
  }

  @override
  void dispose() {
    _privacyRecognizer.dispose();
    _termsRecognizer.dispose();
    super.dispose();
  }

  /// Custom TextField Widget with icon
  Widget _buildTextField({
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
  }) {
    return TextField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.black54, size: 18.sp),
        prefixIconConstraints: BoxConstraints(
          minWidth: 40.w, // default se kam width
          minHeight: 30.h,
        ),
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14.sp, color: Colors.black54),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppsColors.primary, width: 1),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.all(8.w),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: IconButton(
            icon: Icon(CupertinoIcons.back, color: Colors.black, size: 24.sp),
            onPressed: () => NavHelper.backToLogin(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10.h),
            Align(
               alignment: Alignment.centerLeft,
              child: Text(
                'Let’s create your account',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // First + Last Name in Row
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    hintText: 'First Name',
                    icon: Icons.person_outline,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildTextField(
                    hintText: 'Last Name',
                    icon: Icons.person_outline,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Email
            _buildTextField(
              hintText: 'E-Mail',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.h),

            // Phone
            _buildTextField(
              hintText: 'Phone Number',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16.h),

            // Password
            _buildTextField(
              hintText: 'Password',
              icon: Icons.lock_outline,
              obscureText: true,
            ),
            SizedBox(height: 16.h),

            // Terms & Privacy checkbox
            Align(
              
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Checkbox(
                    value: agreeTerms,
                    onChanged: (val) {
                      setState(() {
                        agreeTerms = val ?? false;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    activeColor: AppsColors.primary,
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black54, fontSize: 13.sp),
                        children: [
                          const TextSpan(text: 'I agree to '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: AppsColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: _privacyRecognizer,
                          ),
                          const TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Terms of Use',
                            style: TextStyle(
                              color: AppsColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: _termsRecognizer,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Create Account Button
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: agreeTerms
                    ? () {
                        // Create account logic
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppsColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 2,
                ),
                child: Text(
                  'Create Account',
                  style: TextStyle(fontSize: 18.sp, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Divider with text
            Row(
              children: [
                Expanded(
                  child: Divider(thickness: 1, color: Colors.grey.shade300),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    "or ",
                    style: TextStyle(color: Colors.black54, fontSize: 13.sp),
                  ),
                ),
                Expanded(
                  child: Divider(thickness: 1, color: Colors.grey.shade300),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // Already have account
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black54, fontSize: 14.sp),
                children: [
                  const TextSpan(text: "Already have an account? "),
                  TextSpan(
                    text: "Sign In",
                    style: TextStyle(
                      color: AppsColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        NavHelper.goToLogin();
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
