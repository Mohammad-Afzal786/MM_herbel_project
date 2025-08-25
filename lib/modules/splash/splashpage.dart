import 'package:flutter/material.dart';
import 'dart:math';
import 'package:get/get.dart';
import 'package:mmherbel/theme/app_colors.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// =============================================================
/// 🚀 SplashPage
/// =============================================================
/// यह app का पहला page है (launch होने पर दिखेगा)
/// इसमें:
///   ✅ Logo animation होगा (ऊपर से slide होकर आएगा)
///   ✅ एक circle animation होगा (progress की तरह घूमेगा)
///   ✅ नीचे "From Kashif Khan" लिखा हुआ आएगा
///   ✅ 4 sec बाद navigation होगा:
///       - अगर user ने intro देखा है → `/login`
///       - अगर नहीं देखा है → `/intro`
///
/// Responsive design के लिए `flutter_screenutil` का use किया गया है
/// (हर जगह `.w`, `.h`, `.sp` इस्तेमाल हुआ है)
/// =============================================================
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage>
    with TickerProviderStateMixin {
  /// Local storage instance (GetStorage)
  /// - इसमें हम check करेंगे कि "intro पहले देखा है या नहीं"
  final box = GetStorage();

  /// Animation controllers
  late AnimationController _logoController;   // Logo + bottom text के लिए
  late AnimationController _circleController; // Circle animation के लिए

  /// Animations
  late Animation<Offset> _logoAnimation;      // Logo → slide top से center
  late Animation<Offset> _textAnimation;      // Text → slide bottom से ऊपर

  @override
  void initState() {
    super.initState();

    /// ✅ Navigation logic (4 sec delay)
    /// splash screen के बाद:
    ///   - अगर "seenIntro" true है → LoginPage
    ///   - वरना → IntroPage
    Future.delayed(const Duration(seconds: 4), () {
      bool seenIntro = box.read('seenIntro') ?? false;
      if (seenIntro) {
        Get.offAllNamed('/login'); // direct login
      } else {
        Get.offAllNamed('/intro'); // first time intro
      }
    });

    /// ✅ Logo animation controller (1 second)
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    /// ✅ Circle animation controller (2 seconds)
    _circleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    /// ✅ Logo slide animation
    _logoAnimation = Tween<Offset>(
      begin: const Offset(0, -1), // ऊपर से
      end: const Offset(0, 0),   // center तक
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeOut,
    ));

    /// ✅ Bottom text slide animation
    _textAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // नीचे से
      end: const Offset(0, 0),   // अपनी जगह
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeOut,
    ));

    /// Flow:
    /// 1. पहले logo animate होगा
    /// 2. फिर circle animate होगा
    _logoController.forward().whenComplete(() {
      _circleController.forward();
    });
  }

  @override
  void dispose() {
    /// Controllers dispose करना जरूरी है
    _logoController.dispose();
    _circleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppsColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            /// 🌀 BACKGROUND CIRCLE ANIMATION
            Center(
              child: AnimatedBuilder(
                animation: _circleController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: CircleSweepPainter(_circleController.value),
                    child: SizedBox(
                      width: 220.w, // responsive size
                      height: 220.w,
                    ),
                  );
                },
              ),
            ),

            /// ✅ LOGO (center में)
            Align(
              alignment: Alignment.center,
              child: SlideTransition(
                position: _logoAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 150.w,
                      height: 150.w,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),

            /// ✅ BOTTOM TEXT ("From Kashif Khan")
            Positioned(
              bottom: 30.h,
              left: 0,
              right: 0,
              child: SlideTransition(
                position: _textAnimation,
                child: Column(
                  children: [
                    Text(
                      "From",
                      style: TextStyle(
                        color: AppsColors.primary,
                        fontSize: 14.sp,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Text(
                      "Kashif Khan",
                      style: TextStyle(
                        color: AppsColors.primary,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// =============================================================
/// 🎨 CircleSweepPainter
/// =============================================================
/// यह custom painter circle को draw करता है
/// - progress (0 → 1) के हिसाब से circle arc बढ़ता जाता है
/// - strokeCap.round से edges गोल रहते हैं
/// =============================================================
class CircleSweepPainter extends CustomPainter {
  final double progress;
  CircleSweepPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 2.0.w; // responsive stroke
    final radius = min(size.width, size.height) / 2 - strokeWidth;

    final paint = Paint()
      ..color = AppsColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);

    /// Circle का start angle → ऊपर से (-pi/2)
    /// Sweep angle → progress * 360°
    final startAngle = -pi / 2;
    final sweepAngle = 2 * pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
