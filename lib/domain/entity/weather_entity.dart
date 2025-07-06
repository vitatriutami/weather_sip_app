class WeatherEntity {
  final String city;
  final double temperature;
  final String weatherDescription;

  WeatherEntity({
    required this.city,
    required this.temperature,
    required this.weatherDescription,
  });

  // Factory untuk parsing dari JSON API (opsional)
  factory WeatherEntity.fromJson(Map<String, dynamic> json) {
    return WeatherEntity(
      city: json['name'],
      temperature: json['main']['temp'].toDouble(),
      weatherDescription: json['weather'][0]['description'],
    );
  }
}
