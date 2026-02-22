import 'package:pokedex/api/client.dart';
import 'package:pokedex/api/extensions/parse_response.dart';
import 'package:pokedex/modules/weather/models/weather_response.dart';
import 'package:pokedex/services/weather_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weather_state.g.dart';

@riverpod
class WeatherState extends _$WeatherState {
  @override
  FutureOr<WeatherResponse?> build() {
    final weatherClient = ref.read(chopperWeatherProvider);
    final weatherService = WeatherService.create(weatherClient);

    return weatherService.getCurrentWeather(latitude: 35.6762, longitude: 139.6503).parseResponse;
  }
}
