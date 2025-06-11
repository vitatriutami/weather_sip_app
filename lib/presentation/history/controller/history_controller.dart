// lib/presentation/history/controller/history_controller.dart
import 'package:get/get.dart';
import '../../../domain/entity/drink_recommendation_entity.dart';

class HistoryController extends GetxController {
  final historyList = <DrinkRecommendationEntity>[].obs;

  void addToHistory(DrinkRecommendationEntity item) {
    historyList.add(item);
  }

  void clearHistory() {
    historyList.clear();
  }
}
