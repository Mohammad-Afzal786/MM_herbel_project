import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mmherbel/config/routes.dart';
import 'package:mmherbel/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 804),
      minTextAdapt: true,
      builder: (context, _) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "MM Herbel",

          // ✅ Theme
          theme: AppTheme.lightTheme,
          themeMode: ThemeMode.system,

          // ✅ Routes
          initialRoute: AppRoutes.splash,
          getPages: AppRoutes.pages,

          // ✅ (Optional) Localization support
          // translations: AppTranslations(),
          // locale: const Locale('en', 'US'),
          // fallbackLocale: const Locale('en', 'US'),
        );
      },
    );
  }
}
