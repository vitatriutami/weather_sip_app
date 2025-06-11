import 'package:get/get.dart';
import '../controller/weather_controller.dart';

class WeatherBinding extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments ?? {};
    final userName = args['user_name'] ?? 'User';
    final userDrink = args['user_drink'] ?? 'Kopi';

    Get.lazyPut<WeatherController>(
      () => WeatherController(userName: userName, userDrink: userDrink),
    );
  }
}
