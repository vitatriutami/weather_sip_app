import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_sip_app/domain/service/drink_recommender_service.dart';
import 'package:weather_sip_app/domain/entity/user_preference_entity.dart';
import 'package:weather_sip_app/domain/entity/weather_entity.dart';

class WeatherController extends GetxController {
  final temperature = 0.0.obs;
  final isLoading = true.obs;
  final drinkRecommendation = "".obs;
  final userDrinkImage = "".obs;
  final Map<String, String> drinkImageMap = {
    "Kopi": "assets/images/item_1.png",
    "Teh": "assets/images/item_2.png",
    "Coklat": "assets/images/item_3.png",
    "Matcha": "assets/images/item_4.png",
  };

  final imagePath = "".obs;

  late final String userName;
  late final String userDrink;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>;
    userName = args['user_name'];
    userDrink = args['user_drink'];
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
      final apiKey = dotenv.env['WEATHER_API_KEY'];

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

    userDrinkImage.value =
        drinkImageMap[result.drinkName] ??
        ''; // fallback ke '' jika tidak ketemu

    imagePath.value = result.imagePath;
  }
}
