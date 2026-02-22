import 'package:json_annotation/json_annotation.dart';

part 'weather_response.g.dart';

@JsonSerializable()
class WeatherResponse {
  final double latitude;
  final double longitude;
  @JsonKey(name: 'current')
  final CurrentWeather current;

  const WeatherResponse({
    required this.latitude,
    required this.longitude,
    required this.current,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) => _$WeatherResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherResponseToJson(this);
}

@JsonSerializable()
class CurrentWeather {
  @JsonKey(name: 'temperature_2m')
  final double temperature;
  @JsonKey(name: 'wind_speed_10m')
  final double windSpeed;
  @JsonKey(name: 'weather_code')
  final int weatherCode;

  const CurrentWeather({
    required this.temperature,
    required this.windSpeed,
    required this.weatherCode,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) => _$CurrentWeatherFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentWeatherToJson(this);
}
