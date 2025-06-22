import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'myapp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  print(dotenv.env['WEATHER_API_KEY']); // cek apakah nilainya null
  await GetStorage.init(); // init storage

  runApp(const MyApp());
}
