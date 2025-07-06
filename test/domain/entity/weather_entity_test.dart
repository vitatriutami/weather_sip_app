import 'package:flutter_test/flutter_test.dart';
import 'package:weather_sip_app/domain/entity/weather_entity.dart';

void main() {
  group('WeatherEntity', () {
    test('should store city, temperature, and description correctly', () {
      final weather = WeatherEntity(
        city: 'Bandung',
        temperature: 28.5,
        weatherDescription: 'Cerah berawan',
      );

      expect(weather.city, 'Bandung');
      expect(weather.temperature, 28.5);
      expect(weather.weatherDescription, 'Cerah berawan');
    });

    test('should parse from JSON correctly', () {
      final json = {
        'name': 'Jakarta',
        'main': {'temp': 30.0},
        'weather': [
          {'description': 'hujan ringan'},
        ],
      };

      final weather = WeatherEntity.fromJson(json);

      expect(weather.city, 'Jakarta');
      expect(weather.temperature, 30.0);
      expect(weather.weatherDescription, 'hujan ringan');
    });
  });
}
