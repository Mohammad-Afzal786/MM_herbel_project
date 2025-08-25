import 'package:get/get.dart';
import 'package:mmherbel/modules/auth/createuser/createaccountpage.dart';
import 'package:mmherbel/modules/auth/forgetpass/forgetpass.dart';
import 'package:mmherbel/modules/auth/presentation/pages/login_wrapper.dart';
import 'package:mmherbel/modules/deshboard/deshboard.dart';
import 'package:mmherbel/modules/deshboard/editprofile.dart';
import 'package:mmherbel/modules/intro/intropage.dart';
import 'package:mmherbel/modules/splash/splashpage.dart';

class AppRoutes {
  // ✅ Route names (constants)
  static const String splash = '/splash';
  static const String intro = '/intro';
  static const String createAccount = '/createaccount';
  static const String forgetPassword = '/forgetpassword';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String editProfile = '/editprofile';

  // ✅ Route pages
  static final List<GetPage> pages = [
    GetPage(name: splash, page: () => SplashPage()),
    GetPage(name: intro, page: () => Intropage()),
    GetPage(name: createAccount, page: () => CreateAccountPage()),
    GetPage(name: forgetPassword, page: () => ForgotPasswordScreen()),
    GetPage(name: login, page: () => const LoginWrapper()),
    GetPage(name: dashboard, page: () => Dashboard()),
    GetPage(name: editProfile, page: () => EditProfilePage()),
  ];
}
