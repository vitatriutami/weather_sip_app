import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class HomeController extends GetxController {
  final nameController = TextEditingController();
  final RxString selectedDrink = "Kopi".obs;

  final List<String> drinkOptions = ["Kopi", "Teh", "Coklat", "Matcha"];

  void saveUserPreference() async {
    final name = nameController.text.trim();
    final drink = selectedDrink.value;

    if (name.isEmpty || drink.isEmpty) {
      Get.snackbar("Peringatan", "Isi nama dan pilih minuman dulu!");
      return;
    }

    // 🔐 1. Minta izin lokasi (popup muncul otomatis di sini)
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar("Izin Ditolak", "Aplikasi butuh izin lokasi.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
        "Ditolak Permanen",
        "Buka pengaturan & aktifkan izin lokasi.",
      );
      return;
    }

    // ✅ 2. Ambil lokasi (trigger GPS nyala)
    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    print("Lokasi pengguna: ${position.latitude}, ${position.longitude}");

    // ✅ 3. Simpan preferensi dan navigasi
    Get.toNamed(
      '/weather',
      arguments: {
        'user_name': name,
        'user_drink': drink,
        'lat': position.latitude,
        'lon': position.longitude,
      },
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }
}
