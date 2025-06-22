import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HistoryController extends GetxController {
  final historyList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadHistory(); // ⬅ penting
  }

  void loadHistory() {
    final box = GetStorage();
    final name = box.read('user_name');
    final drink = box.read('user_drink');
    final lat = box.read('user_lat');
    final lon = box.read('user_lon');

    if (name != null && drink != null && lat != null && lon != null) {
      historyList.add({'name': name, 'drink': drink, 'lat': lat, 'lon': lon});
    }
  }

  void clearHistory() {
    final box = GetStorage();
    box.remove('user_name');
    box.remove('user_drink');
    box.remove('user_lat');
    box.remove('user_lon');

    historyList.clear();
  }
}
