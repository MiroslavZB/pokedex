import 'package:chopper/chopper.dart';
import 'package:pokedex/modules/weather/models/weather_response.dart';

part 'weather_service.chopper.dart';

@ChopperApi(baseUrl: 'https://api.open-meteo.com/v1')
abstract class WeatherService extends ChopperService {
  @GET(path: '/forecast')
  Future<Response<WeatherResponse>> getCurrentWeather({
    @Query('latitude') required double latitude,
    @Query('longitude') required double longitude,
    @Query('current') String current = 'temperature_2m,wind_speed_10m,weather_code',
  });

  static WeatherService create(ChopperClient client) {
    return _$WeatherService(client);
  }
}
