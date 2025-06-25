import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_sip_app/sharing/component/widget/gradient_scaffold.dart';
import 'package:weather_sip_app/sharing/component/widget/my_app_bar.dart';
import 'controller/history_controller.dart';

class HistoryScreen extends GetView<HistoryController> {
  const HistoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Recommendation History",
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: controller.clearHistory,
            tooltip: "Delete all",
          ),
        ],
      ),
      body: GradientScaffold(
        child: Obx(() {
          if (controller.historyList.isEmpty) {
            return const Center(child: Text("There is no history."));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              ...controller.historyList.map((entry) {
                final name = entry['name'] ?? '—';
                final drink = entry['drink'] ?? '—';
                final lat =
                    (entry['lat'] as double?)?.toStringAsFixed(4) ?? '—';
                final lon =
                    (entry['lon'] as double?)?.toStringAsFixed(4) ?? '—';

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nama: $name", style: const TextStyle(fontSize: 18)),
                    Text(
                      "Minuman favorit: $drink",
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Koordinat: Lat: $lat, Lon: $lon",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const Divider(),
                  ],
                );
              }),
            ],
          );
        }),
      ),
    );
  }
}
