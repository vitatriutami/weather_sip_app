import 'package:flutter_test/flutter_test.dart';
import 'package:weather_sip_app/domain/entity/drink_recommendation_entity.dart';

void main() {
  group('DrinkRecommendationEntity', () {
    test('readableTemperature returns correct string for each temperature', () {
      final hotDrink = DrinkRecommendationEntity(
        drinkName: 'Teh',
        drinkTemperature: DrinkTemperature.hot,
        size: '250ml',
        imagePath: 'assets/images/teh.png',
      );

      final warmDrink = DrinkRecommendationEntity(
        drinkName: 'Susu',
        drinkTemperature: DrinkTemperature.warm,
        size: '300ml',
        imagePath: 'assets/images/susu.png',
      );

      final coldDrink = DrinkRecommendationEntity(
        drinkName: 'Es Jeruk',
        drinkTemperature: DrinkTemperature.cold,
        size: '350ml',
        imagePath: 'assets/images/es_jeruk.png',
      );

      expect(hotDrink.readableTemperature, 'Panas');
      expect(warmDrink.readableTemperature, 'Hangat');
      expect(coldDrink.readableTemperature, 'Dingin');
    });
  });
}
