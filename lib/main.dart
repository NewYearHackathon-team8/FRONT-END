import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/for_provider/main_screen_for_provider.dart';
import 'screens/login_screen.dart';
import 'controllers/auth_controller.dart';
import 'screens/main_screen.dart';

void main() {
  Get.put(AuthController());
  runApp(const HanJibungApp());
}

class HanJibungApp extends StatelessWidget {
  const HanJibungApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '한지붕',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}
