import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import 'package:weather_sip_app/presentation/home/home_screen.dart';
import 'package:weather_sip_app/presentation/home/controller/home_controller.dart';

class MockHomeController extends Mock implements HomeController {}

void main() {
  late MockHomeController mockController;

  setUp(() {
    Get.reset();
    mockController = MockHomeController();

    // Stub data untuk dipakai di widget
    when(
      () => mockController.nameController,
    ).thenReturn(TextEditingController());
    when(() => mockController.selectedDrink).thenReturn("Kopi".obs);
    when(() => mockController.saveUserPreference()).thenAnswer((_) async => {});

    Get.put<HomeController>(mockController);
  });

  testWidgets('HomeScreen renders correctly and responds to tap', (
    tester,
  ) async {
    await tester.pumpWidget(const GetMaterialApp(home: HomeScreen()));

    // Cek widget utama muncul
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
    expect(find.text('Kopi'), findsOneWidget);
    expect(find.text('Teh'), findsOneWidget);

    // Tap item minuman
    await tester.tap(find.text('Kopi'));
    await tester.pumpAndSettle();

    // Tap tombol "Continue"
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    // Verifikasi bahwa saveUserPreference dipanggil
    verify(() => mockController.saveUserPreference()).called(1);
  });
}
