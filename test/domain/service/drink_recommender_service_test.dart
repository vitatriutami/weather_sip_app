import 'package:flutter_test/flutter_test.dart';
import 'package:weather_sip_app/domain/service/drink_recommender_service.dart';
import 'package:weather_sip_app/domain/entity/user_preference_entity.dart';
import 'package:weather_sip_app/domain/entity/weather_entity.dart';
import 'package:weather_sip_app/domain/entity/drink_recommendation_entity.dart';

void main() {
  group('DrinkRecommenderService', () {
    final service = DrinkRecommenderService();
    final user = UserPreferenceEntity(name: 'Andi', favoriteDrink: 'Kopi');

    test('should recommend hot drink when temperature <= 20', () {
      final weather = WeatherEntity(
        city: 'Bogor',
        temperature: 18.0,
        weatherDescription: 'Hujan',
      );

      final result = service.recommend(user: user, weather: weather);

      expect(result.drinkTemperature, DrinkTemperature.hot);
      expect(result.size, '500ml');
      expect(result.imagePath, 'assets/images/hot_large.jpg');
      expect(result.drinkName, 'Kopi');
    });

    test('should recommend warm drink when temperature <= 30', () {
      final weather = WeatherEntity(
        city: 'Bandung',
        temperature: 25.0,
        weatherDescription: 'Berawan',
      );

      final result = service.recommend(user: user, weather: weather);

      expect(result.drinkTemperature, DrinkTemperature.warm);
      expect(result.size, '350ml');
      expect(result.imagePath, 'assets/images/warm_medium.jpg');
    });

    test('should recommend cold drink when temperature > 30', () {
      final weather = WeatherEntity(
        city: 'Jakarta',
        temperature: 32.5,
        weatherDescription: 'Cerah',
      );

      final result = service.recommend(user: user, weather: weather);

      expect(result.drinkTemperature, DrinkTemperature.cold);
      expect(result.size, '500ml');
      expect(result.imagePath, 'assets/images/cold_large.jpg');
    });
  });
}
