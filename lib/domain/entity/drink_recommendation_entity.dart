enum DrinkTemperature { hot, warm, cold }

class DrinkRecommendationEntity {
  final String drinkName;
  final DrinkTemperature drinkTemperature;
  final String size; // Contoh: "500ml"
  final String imagePath;

  DrinkRecommendationEntity({
    required this.drinkName,
    required this.drinkTemperature,
    required this.size,
    required this.imagePath,
  });

  String get readableTemperature {
    switch (drinkTemperature) {
      case DrinkTemperature.hot:
        return "Panas";
      case DrinkTemperature.warm:
        return "Hangat";
      case DrinkTemperature.cold:
        return "Dingin";
    }
  }
}
