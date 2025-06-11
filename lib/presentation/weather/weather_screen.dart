// lib/presentation/weather/weather_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/weather_controller.dart';

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WeatherController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Weather & Recommendation")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                "Hi, ${controller.userName}",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(
                "Now temperature: ${controller.temperature}°C",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 30),
              Image.asset(controller.imagePath.value, height: 150),
              const SizedBox(height: 20),
              Text(
                "Recommendation: ${controller.drinkRecommendation}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
