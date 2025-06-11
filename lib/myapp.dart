// lib/myapp.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Import halaman dan binding
import 'presentation/home/home_screen.dart';
import 'presentation/home/binding/home_binding.dart';

import 'presentation/weather/weather_screen.dart';
import 'presentation/weather/binding/weather_binding.dart';

import 'presentation/history/history_screen.dart';
import 'presentation/history/binding/history_binding.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: Get.key,
      title: 'WeatherSip',
      debugShowCheckedModeBanner: false, // ✅ Nonaktifkan tulisan DEBUG
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const HomeScreen(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: '/weather',
          page: () => WeatherScreen(),
          binding: WeatherBinding(),
          transition: Transition.cupertino,
        ),
        GetPage(
          name: '/history',
          page: () => HistoryScreen(),
          binding: HistoryBinding(),
          transition: Transition.fadeIn,
        ),
      ],
    );
  }
}
