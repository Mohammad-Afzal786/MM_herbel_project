// lib/features/auth/presentation/pages/login_page.dart
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../core/utils/nav_helper.dart'; // अगर इस्तेमाल करना चाहो
import '../../../../theme/app_colors.dart';
import '../../auth_injection.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // form + controllers
  final _formKey = GlobalKey<FormState>();
  final box = GetStorage();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool rememberMe = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();

    // Auto-load saved values (Remember Me)
    final savedRemember = box.read('rememberMe') ?? false;
    if (savedRemember) {
      emailController.text = box.read('email') ?? '';
      passwordController.text = box.read('password') ?? '';
      rememberMe = true;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onSubmit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    // Remember me persist
    if (rememberMe) {
      box.write('email', emailController.text.trim());
      box.write('password', passwordController.text.trim());
      box.write('rememberMe', true);
    } else {
      box.remove('email');
      box.remove('password');
      box.write('rememberMe', false);
    }

    // Fire BLoC event
    context.read<LoginBloc>().add(
          LoginSubmitted(
            emailController.text.trim(),
            passwordController.text.trim(),
          ),
        );
  }

  /// Reusable TextField
  Widget _buildTextField({
    required String hintText,
    required IconData icon,
    required TextEditingController controller,
    bool obscureText = false,
    Widget? suffix,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.black54, size: 18.sp),
        prefixIconConstraints: BoxConstraints(minWidth: 35.w, minHeight: 30.h),
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
        suffixIcon: suffix,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (_) => sl<LoginBloc>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) async {
              if (state.status == LoginStatus.success) {

                // tokens save करने हों तो यहाँ कर दो (अगर response repo से उपलब्ध हो)
                // Example (optional): box.write('accessToken', state.userToken);
              box.write('accessToken', state.data!.accessToken);  // अपनी model field के अनुसार
               box.write('refreshToken', state.data!.refreshToken);
                

                // NavHelper use करना चाहो:
                 NavHelper.goToDashboard();
               
              } else if (state.status == LoginStatus.failure) {
               ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error ?? 'Error')),
            );
              }
            },
            builder: (context, state) {
              final isLoading = state.status == LoginStatus.loading;

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Logo + Welcome
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 70.w,
                            child: Image.asset(
                              'assets/images/logodesh.png',
                              width: 130.w,
                              height: 130.w,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "Welcome back,",
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "Discover Limitless Choices and Unmatched\nConvenience.",
                            textAlign: TextAlign.start,
                            style:
                                TextStyle(fontSize: 13.sp, color: Colors.black54),
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),

                      // Email Field
                      _buildTextField(
                        controller: emailController,
                        hintText: 'E-Mail',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Email required';
                          }
                          // simple email check
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v.trim())) {
                            return 'Enter valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),

                      // Password Field
                      _buildTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        icon: Icons.lock_outline,
                        obscureText: _obscurePassword,
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Password required';
                          if (v.length < 6) return 'Min 6 characters';
                          return null;
                        },
                        suffix: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            size: 20.sp,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 8.h),

                      // Remember Me + Forgot Password
                      Row(
                        children: [
                          Checkbox(
                            value: rememberMe,
                            onChanged: isLoading
                                ? null
                                : (value) {
                                    setState(() {
                                      rememberMe = value ?? false;
                                    });
                                  },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                          Text("Remember Me", style: TextStyle(fontSize: 14.sp)),
                          const Spacer(),
                          GestureDetector(
                            onTap: () => Get.toNamed('/forgetpassword'),
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: AppsColors.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),

                      // Sign In Button
                      SizedBox(
                        width: double.infinity,
                        height: 48.h,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : () => _onSubmit(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppsColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                )
                              : Text(
                                  "Sign In",
                                  style: TextStyle(fontSize: 18.sp, color: Colors.white),
                                ),
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // Divider with "or"
                      Row(
                        children: [
                          Expanded(
                            child: Divider(thickness: 1, color: Colors.grey.shade300),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Text(
                              "or",
                              style: TextStyle(color: Colors.black54, fontSize: 13.sp),
                            ),
                          ),
                          Expanded(
                            child: Divider(thickness: 1, color: Colors.grey.shade300),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),

                      // Create Account
                      Center(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.black54, fontSize: 14.sp),
                            children: [
                              const TextSpan(text: "Don't have an account? "),
                              TextSpan(
                                text: "Create Account",
                                style: TextStyle(
                                  color: AppsColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.toNamed('/createaccount');
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
