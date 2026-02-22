import 'package:pokedex/modules/weather/models/weather_response.dart';

abstract class WeatherToPokemonTypeService {
  /// Maps weather conditions to Pokemon type suggestions
  ///
  /// Reasoning:
  /// - Temperature-based: Hot weather suggests fire types, cold suggests ice
  /// - Weather code-based: Rain suggests water, thunderstorm suggests electric
  /// - Wind-based: High wind suggests flying types
  static String getPokemonTypeFromWeather(CurrentWeather weather) {
    final temp = weather.temperature;
    final windSpeed = weather.windSpeed;
    final weatherCode = weather.weatherCode;

    // Priority 1: Weather code (most specific)
    // WMO Weather interpretation codes
    if (weatherCode >= 95 && weatherCode <= 99) {
      // Thunderstorm
      return 'electric';
    } else if (weatherCode >= 80 && weatherCode <= 82) {
      // Rain showers
      return 'water';
    } else if (weatherCode >= 71 && weatherCode <= 77) {
      // Snow
      return 'ice';
    } else if (weatherCode >= 61 && weatherCode <= 67) {
      // Rain
      return 'water';
    } else if (weatherCode >= 51 && weatherCode <= 57) {
      // Drizzle
      return 'water';
    } else if (weatherCode >= 45 && weatherCode <= 48) {
      // Fog
      return 'ghost';
    }

    // Priority 2: Wind speed
    if (windSpeed > 30) {
      // Strong wind (> 30 km/h)
      return 'flying';
    }

    // Priority 3: Temperature
    if (temp > 30) {
      // Very hot
      return 'fire';
    } else if (temp > 25) {
      // Hot
      return 'fire';
    } else if (temp > 20) {
      // Warm
      return 'grass';
    } else if (temp > 15) {
      // Mild
      return 'normal';
    } else if (temp > 10) {
      // Cool
      return 'rock';
    } else if (temp > 5) {
      // Cold
      return 'ice';
    } else {
      // Very cold
      return 'ice';
    }
  }

  /// Get a human-readable description of why this type was suggested
  static String getReasonForSuggestion(CurrentWeather weather) {
    final temp = weather.temperature;
    final windSpeed = weather.windSpeed;
    final weatherCode = weather.weatherCode;

    if (weatherCode >= 95 && weatherCode <= 99) {
      return 'Thunderstorm detected - Electric types thrive in storms!';
    } else if (weatherCode >= 80 && weatherCode <= 82) {
      return 'Rain showers - Water types love the rain!';
    } else if (weatherCode >= 71 && weatherCode <= 77) {
      return 'Snowing - Ice types are in their element!';
    } else if (weatherCode >= 61 && weatherCode <= 67) {
      return 'Rainy weather - Water types are active!';
    } else if (weatherCode >= 51 && weatherCode <= 57) {
      return 'Light rain - Water types are out!';
    } else if (weatherCode >= 45 && weatherCode <= 48) {
      return 'Foggy conditions - Ghost types emerge!';
    }

    if (windSpeed > 30) {
      return 'Strong winds (${windSpeed.toStringAsFixed(1)} km/h) - Flying types soar!';
    }

    if (temp > 30) {
      return 'Very hot (${temp.toStringAsFixed(1)}°C) - Fire types are energized!';
    } else if (temp > 25) {
      return 'Hot weather (${temp.toStringAsFixed(1)}°C) - Fire types love the heat!';
    } else if (temp > 20) {
      return 'Warm day (${temp.toStringAsFixed(1)}°C) - Grass types flourish!';
    } else if (temp > 15) {
      return 'Mild temperature (${temp.toStringAsFixed(1)}°C) - Normal types are active!';
    } else if (temp > 10) {
      return 'Cool weather (${temp.toStringAsFixed(1)}°C) - Rock types are sturdy!';
    } else if (temp > 5) {
      return 'Cold (${temp.toStringAsFixed(1)}°C) - Ice types appear!';
    } else {
      return 'Very cold (${temp.toStringAsFixed(1)}°C) - Ice types dominate!';
    }
  }
}
