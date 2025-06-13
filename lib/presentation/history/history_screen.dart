// lib/presentation/history/history_screen.dart
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
      ),
    );
  }
}
