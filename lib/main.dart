import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mmherbel/modules/auth/auth_injection.dart';
import 'package:mmherbel/modules/notification/push_notification_service.dart';
import 'package:mmherbel/config/firebase_options.dart';
import 'app.dart';
const String baseUrl = "http://10.0.2.2:3000/api/";
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Firebase init
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // ✅ Local Storage init
  await GetStorage.init();

  // ✅ Push Notification init
  await PushNotificationService.init();

 await initAuthInjection(baseUrl: baseUrl);

  runApp(const MyApp());
}
