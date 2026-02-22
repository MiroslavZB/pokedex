import 'package:flutter/material.dart';
import 'package:pokedex/modules/weather/models/weather_response.dart';

class CurrentWeatherCard extends StatelessWidget {
  final WeatherResponse weather;
  final String? location;

  const CurrentWeatherCard(this.weather, {this.location, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Icon(
                      _getWeatherIcon(weather.current.weatherCode),
                      size: 32,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          location ?? 'Tokyo',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _getWeatherDescription(weather.current.weatherCode),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _WeatherInfo(
                  icon: Icons.thermostat,
                  label: 'Temperature',
                  value: '${weather.current.temperature.toStringAsFixed(1)}°C',
                ),
                _WeatherInfo(
                  icon: Icons.air,
                  label: 'Wind Speed',
                  value: '${weather.current.windSpeed.toStringAsFixed(1)} km/h',
                ),
              ],
            ),
            if (_shouldShowPrecipitation(weather.current.weatherCode)) ...[
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(Icons.water_drop, size: 20, color: Colors.blue[700]),
                    ),
                    Text(
                      _getPrecipitationText(weather.current.weatherCode),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getWeatherIcon(int weatherCode) {
    if (weatherCode >= 95 && weatherCode <= 99) {
      return Icons.thunderstorm;
    } else if (weatherCode >= 80 && weatherCode <= 82) {
      return Icons.grain; // rain showers
    } else if (weatherCode >= 71 && weatherCode <= 77) {
      return Icons.ac_unit; // snow
    } else if (weatherCode >= 61 && weatherCode <= 67) {
      return Icons.water_drop; // rain
    } else if (weatherCode >= 51 && weatherCode <= 57) {
      return Icons.water_drop_outlined; // drizzle
    } else if (weatherCode >= 45 && weatherCode <= 48) {
      return Icons.foggy; // fog
    } else if (weatherCode >= 1 && weatherCode <= 3) {
      return Icons.cloud; // cloudy
    }
    return Icons.wb_sunny; // clear
  }

  String _getWeatherDescription(int weatherCode) {
    if (weatherCode >= 95 && weatherCode <= 99) {
      return 'Thunderstorm';
    } else if (weatherCode >= 80 && weatherCode <= 82) {
      return 'Rain Showers';
    } else if (weatherCode >= 71 && weatherCode <= 77) {
      return 'Snow';
    } else if (weatherCode >= 61 && weatherCode <= 67) {
      return 'Rain';
    } else if (weatherCode >= 51 && weatherCode <= 57) {
      return 'Drizzle';
    } else if (weatherCode >= 45 && weatherCode <= 48) {
      return 'Foggy';
    } else if (weatherCode >= 1 && weatherCode <= 3) {
      return 'Cloudy';
    }
    return 'Clear';
  }

  bool _shouldShowPrecipitation(int weatherCode) {
    // Show precipitation info for rain, drizzle, snow, or thunderstorm
    return weatherCode >= 51;
  }

  String _getPrecipitationText(int weatherCode) {
    if (weatherCode >= 95 && weatherCode <= 99) {
      return 'Heavy precipitation expected';
    } else if (weatherCode >= 80 && weatherCode <= 82) {
      return 'Rain showers expected';
    } else if (weatherCode >= 71 && weatherCode <= 77) {
      return 'Snowfall expected';
    } else if (weatherCode >= 61 && weatherCode <= 67) {
      return 'Rainfall expected';
    } else if (weatherCode >= 51 && weatherCode <= 57) {
      return 'Light drizzle expected';
    }
    return 'Precipitation expected';
  }
}

class _WeatherInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _WeatherInfo({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Colors.grey[700]),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 4),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
