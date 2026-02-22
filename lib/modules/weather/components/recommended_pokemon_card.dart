import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokedex/modules/weather/components/pokemon_loading_card.dart';
import 'package:pokedex/modules/weather/components/pokemon_recommendation_card.dart';
import 'package:pokedex/state/pokemon_by_type_state.dart';

class RecommendedPokemonCard extends HookConsumerWidget {
  final String suggestedType;
  const RecommendedPokemonCard(this.suggestedType, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonByTypeState = ref.watch(pokemonByTypeProvider(suggestedType));

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: pokemonByTypeState.when(
        data: (pokemon) => PokemonRecommendationCard(pokemon: pokemon),
        loading: () => const PokemonLoadingCard(),
        error: (error, stack) => Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 8),
                    child: Text(
                      'No recommendations available',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Text(
                    error.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
