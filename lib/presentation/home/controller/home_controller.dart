import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final nameController = TextEditingController();
  final RxString selectedDrink = "Kopi".obs;

  final List<String> drinkOptions = ["Kopi", "Teh", "Coklat", "Matcha"];

  void saveUserPreference() {
    final name = nameController.text.trim();
    final drink = selectedDrink.value;

    if (name.isEmpty) {
      Get.snackbar("Error", "Name can't be empty");
      return;
    }

    // Navigasi ke route '/weather' dan kirim arguments
    Get.toNamed(
      '/weather',
      arguments: {'user_name': name, 'user_drink': drink},
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }
}
