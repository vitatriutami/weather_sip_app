import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:weather_sip_app/domain/service/drink_recommender_service.dart';
import 'package:weather_sip_app/domain/entity/user_preference_entity.dart';
import 'package:weather_sip_app/domain/entity/weather_entity.dart';

class WeatherController extends GetxController {
  final String userName;
  final String userDrink;

  final temperature = 0.0.obs;
  final isLoading = true.obs;
  final drinkRecommendation = "".obs;
  final imagePath = "".obs;

  WeatherController({required this.userName, required this.userDrink});

  @override
  void onInit() {
    super.onInit();
    _savePreferenceToStorage();
    fetchWeather();
  }

  void _savePreferenceToStorage() {
    final box = GetStorage();
    box.write('user_name', userName);
    box.write('user_drink', userDrink);
  }

  Future<void> fetchWeather() async {
    try {
      isLoading.value = true;

      const city = "Jakarta";
      const apiKey = "dcea7cca42c2b1fa316d06a462060282";

      final url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric",
      );

      final response = await http.get(url);
      final data = json.decode(response.body);

      temperature.value = data['main']['temp'].toDouble();
      _setRecommendation(temperature.value);
    } catch (e) {
      Get.snackbar("Error", "Gagal ambil data cuaca");
    } finally {
      isLoading.value = false;
    }
  }

  void _setRecommendation(double temp) {
    final weather = WeatherEntity(
      city: "Jakarta",
      temperature: temp,
      weatherDescription: "—",
    );

    final user = UserPreferenceEntity(name: userName, favoriteDrink: userDrink);

    final result = DrinkRecommenderService().recommend(
      user: user,
      weather: weather,
    );

    drinkRecommendation.value =
        "${result.drinkName} ${result.readableTemperature} - Ukuran ${result.size}";
    imagePath.value = result.imagePath;
  }
}
