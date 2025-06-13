import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:get/get.dart';
import 'myapp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await GetStorage.init();

  // Jika kamu pakai GetStorage, bisa inisialisasi di sini:
  // await GetStorage.init();

  runApp(const MyApp());
}
