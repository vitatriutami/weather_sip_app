// lib/presentation/history/history_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/history_controller.dart';
import '../../domain/entity/drink_recommendation_entity.dart';

class HistoryScreen extends GetView<HistoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recommendation History"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: controller.clearHistory,
            tooltip: "Delete all",
          ),
        ],
      ),
      body: Obx(() {
        if (controller.historyList.isEmpty) {
          return const Center(child: Text("There is no history."));
        }

        return ListView.builder(
          itemCount: controller.historyList.length,
          itemBuilder: (context, index) {
            final item = controller.historyList[index];
            return ListTile(
              leading: Image.asset(item.imagePath, width: 40, height: 40),
              title: Text("${item.drinkName} - ${item.readableTemperature}"),
              subtitle: Text("Ukuran: ${item.size}"),
            );
          },
        );
      }),
    );
  }
}
