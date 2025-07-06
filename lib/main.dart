import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'myapp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final envPath = '${Directory.current.path}/.env';
  final exists = await File(envPath).exists();
  print('CWD: ${Directory.current.path}');
  print('.env found: $exists');

  await dotenv.load(fileName: envPath); // absolute path
  print('API Key: ${dotenv.env['WEATHER_API_KEY']}');

  await GetStorage.init();
  runApp(const MyApp());
}
