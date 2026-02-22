import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokedex/modules/weather/components/current_weather_card.dart';
import 'package:pokedex/modules/weather/components/current_weather_summary_card.dart';
import 'package:pokedex/modules/weather/components/recommended_pokemon_card.dart';
import 'package:pokedex/services/weather_to_pokemon_type_service.dart';
import 'package:pokedex/shared/functions.dart';
import 'package:pokedex/state/weather_state.dart';

class WeatherRecommendationPage extends HookConsumerWidget {
  const WeatherRecommendationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherState = ref.watch(weatherStateProvider);

    return weatherState.when(
      data: (weather) {
        if (weather == null) {
          return Scaffold(
            appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary),
            body: const Center(
              child: Text('No weather data available'),
            ),
          );
        }

        final suggestedType = WeatherToPokemonTypeService.getPokemonTypeFromWeather(weather.current);

        return Scaffold(
          appBar: AppBar(
            title: Text('Recommended: ${suggestedType.capitalizeFirst()}'),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CurrentWeatherSummaryCard(
                  suggestedType: suggestedType,
                  reason: WeatherToPokemonTypeService.getReasonForSuggestion(weather.current),
                ),
                CurrentWeatherCard(weather),
                const Text(
                  'Recommended Pokémon',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RecommendedPokemonCard(suggestedType),
              ],
            ),
          ),
        );
      },
      loading: () => Scaffold(
        appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 60, color: Colors.red),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 8),
                  child: Text(
                    'Failed to fetch weather data',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
