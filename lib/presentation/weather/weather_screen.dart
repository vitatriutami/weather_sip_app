import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_sip_app/sharing/component/widget/gradient_scaffold.dart';
import 'package:weather_sip_app/sharing/component/widget/my_app_bar.dart';
import 'controller/weather_controller.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen>
    with TickerProviderStateMixin {
  late AnimationController _userDrinkController;
  late AnimationController _recommendController;
  late Animation<double> _userDrinkAnimation;
  late Animation<double> _recommendAnimation;

  String toTitleCase(String text) {
    return text
        .split(' ')
        .map(
          (word) =>
              word.isNotEmpty
                  ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
                  : '',
        )
        .join(' ');
  }

  @override
  void initState() {
    super.initState();

    _userDrinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _recommendController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _userDrinkAnimation = CurvedAnimation(
      parent: _userDrinkController,
      curve: Curves.easeOut,
    );
    _recommendAnimation = CurvedAnimation(
      parent: _recommendController,
      curve: Curves.easeOut,
    );

    // Trigger animation setelah build
    Future.delayed(const Duration(milliseconds: 400), () {
      _userDrinkController.forward();
    });
    Future.delayed(const Duration(milliseconds: 800), () {
      _recommendController.forward();
    });
  }

  @override
  void dispose() {
    _userDrinkController.dispose();
    _recommendController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WeatherController>();

    return Scaffold(
      appBar: MyAppBar(
        title: "Weather & Recommendation",
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: "History",
            onPressed: () => Get.toNamed('/history'),
          ),
        ],
      ),
      body: GradientScaffold(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  "Hi, ${toTitleCase(controller.userName)}",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 10),
                Text(
                  "Now temperature: ${controller.temperature}°C",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 30),

                // Animated duo image section
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (controller.userDrinkImage.value.isNotEmpty)
                      ScaleTransition(
                        scale: _userDrinkAnimation,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              controller.userDrinkImage.value,
                              height: 125,
                              width: 125,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ScaleTransition(
                      scale: _recommendAnimation,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            controller.imagePath.value,
                            height: 150,
                            width: 125,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Recommendation text separated
                const Text(
                  "Recommendation:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Text(
                  controller.drinkRecommendation.value,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
