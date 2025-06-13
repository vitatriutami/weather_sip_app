import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_sip_app/sharing/component/widget/gradient_scaffold.dart';
import 'package:weather_sip_app/sharing/component/widget/my_app_bar.dart';
import 'controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    final List<Map<String, String>> drinkList = [
      {"name": "Kopi", "image": "assets/images/item_1.png"},
      {"name": "Teh", "image": "assets/images/item_2.png"},
      {"name": "Coklat", "image": "assets/images/item_3.png"},
      {"name": "Matcha", "image": "assets/images/item_4.png"},
    ];

    return Scaffold(
      appBar: MyAppBar(title: "WeatherSip 🥂"),
      body: GradientScaffold(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: controller.nameController,
                decoration: const InputDecoration(
                  labelText: "Your name:",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Now craving for:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Grid dengan animasi
              Obx(
                () => Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children:
                        drinkList.map((item) {
                          final isSelected =
                              controller.selectedDrink.value == item["name"];

                          return GestureDetector(
                            onTap: () {
                              controller.selectedDrink.value = item["name"]!;
                            },
                            child: Card(
                              elevation: isSelected ? 4 : 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side:
                                    isSelected
                                        ? const BorderSide(
                                          color: Colors.pink,
                                          width: 2,
                                        )
                                        : BorderSide.none,
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Stack(
                                children: [
                                  // Highlight belakang jika selected
                                  if (isSelected)
                                    Container(
                                      color: Colors.pinkAccent.withAlpha(
                                        100,
                                      ), // 40%
                                    ),

                                  // Gambar dengan animasi rotate
                                  AnimatedRotation(
                                    duration: const Duration(milliseconds: 400),
                                    turns:
                                        isSelected
                                            ? -0.05
                                            : 0.0, // sedikit miring
                                    child: Positioned.fill(
                                      child: Image.asset(
                                        item["image"]!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),

                                  // Label minuman
                                  Positioned(
                                    bottom: 4,
                                    left: 8,
                                    right: 8,
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 6),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 2,
                                        horizontal: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withAlpha(
                                          125,
                                        ), // 50
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        item["name"]!,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          shadows: [
                                            Shadow(
                                              blurRadius: 2,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  controller.saveUserPreference();
                },
                child: const Text("Continue"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
