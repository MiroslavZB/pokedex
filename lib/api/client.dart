import 'package:chopper/chopper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokedex/api/interceptors/custom_headers_interceptor.dart';
import 'package:pokedex/api/interceptors/error_interceptor.dart';
import 'package:pokedex/api/serializable_converter.dart';

final chopperPokedexProvider = Provider<ChopperClient>(
  (ref) => ChopperClient(
    baseUrl: Uri.parse('https://pokeapi.co/api/v2'),
    converter: const SerializableConverter(),
    errorConverter: const SerializableConverter(),
    interceptors: [CustomHeadersInterceptor(ref), const ErrorInterceptor()],
  ),
);

final chopperWeatherProvider = Provider<ChopperClient>(
  (ref) => ChopperClient(
    baseUrl: Uri.parse('https://api.open-meteo.com/v1'),
    converter: SerializableConverter(),
    errorConverter: SerializableConverter(),
  ),
);
