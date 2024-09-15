import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/splash_screen.dart';
import 'utils/themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        title: 'Galaxy Planets (Animator)',
        debugShowCheckedModeBanner: false,
        theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
        themeMode: ThemeMode.light,
        home: SplashScreen(),
      ),
    );
  }
}
