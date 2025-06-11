// lib/presentation/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Welcome to WeatherSip")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.nameController,
              decoration: const InputDecoration(
                labelText: "Your name:",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: controller.selectedDrink.value,
              decoration: const InputDecoration(
                labelText: "Now craving for:",
                border: OutlineInputBorder(),
              ),
              items:
                  controller.drinkOptions
                      .map(
                        (drink) =>
                            DropdownMenuItem(value: drink, child: Text(drink)),
                      )
                      .toList(),
              onChanged: (value) {
                if (value != null) {
                  controller.selectedDrink.value = value;
                }
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                controller.saveUserPreference();
                Get.toNamed("/weather");
              },
              child: const Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}
