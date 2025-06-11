import '../entity/user_preference_entity.dart';
import '../entity/weather_entity.dart';
import '../entity/drink_recommendation_entity.dart';

class DrinkRecommenderService {
  DrinkRecommendationEntity recommend({
    required UserPreferenceEntity user,
    required WeatherEntity weather,
  }) {
    final temp = weather.temperature;
    late DrinkTemperature drinkTemp;
    late String size;
    late String imagePath;

    if (temp <= 20) {
      drinkTemp = DrinkTemperature.hot;
      size = "500ml";
      imagePath = "assets/hot_large.jpg";
    } else if (temp <= 30) {
      drinkTemp = DrinkTemperature.warm;
      size = "350ml";
      imagePath = "assets/warm_medium.jpg";
    } else {
      drinkTemp = DrinkTemperature.cold;
      size = "500ml";
      imagePath = "assets/cold_large.jpg";
    }

    return DrinkRecommendationEntity(
      drinkName: user.favoriteDrink,
      drinkTemperature: drinkTemp,
      size: size,
      imagePath: imagePath,
    );
  }
}
