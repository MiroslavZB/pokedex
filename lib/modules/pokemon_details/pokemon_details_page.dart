import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokedex/modules/pokemon_details/components/pokemon_abilities_card.dart';
import 'package:pokedex/modules/pokemon_details/components/pokemon_basic_info_card.dart';
import 'package:pokedex/modules/pokemon_details/components/pokemon_stats_card.dart';
import 'package:pokedex/modules/pokemon_details/components/pokemon_types_card.dart';
import 'package:pokedex/shared/functions.dart';
import 'package:pokedex/modules/pokemon_details/state/pokemon_details_state.dart';
import 'package:pokedex/state/bookmarks_state.dart';

class PokemonDetailsPage extends ConsumerWidget {
  final String pokemonName;

  const PokemonDetailsPage({
    super.key,
    required this.pokemonName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonDetailsState = ref.watch(pokemonDetailsStateProvider(pokemonName));
    final bookmarksNotifier = ref.read(bookmarksStateProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(pokemonName.capitalizeFirst()),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          pokemonDetailsState.maybeWhen(
            data: (pokemon) {
              final isBookmarked = ref.watch(bookmarksStateProvider).any((p) => p.id == pokemon.id);
              return IconButton(
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                ),
                onPressed: () => bookmarksNotifier.toggleBookmark(pokemon),
              );
            },
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: pokemonDetailsState.when(
        data: (pokemon) => SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Hero(
                  tag: 'pokemon_${pokemon.id}',
                  child: Image.network(
                    pokemon.sprites.other?.officialArtwork?.frontDefault ?? pokemon.sprites.frontDefault ?? '',
                    width: 250,
                    height: 250,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.catching_pokemon,
                      size: 250,
                    ),
                  ),
                ),
              ),
              Text(
                pokemon.name.capitalizeFirst(),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '#${pokemon.id}',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[600],
                ),
              ),
              PokemonTypesCard(pokemon.types),
              PokemonBasicInfoCard(pokemon),
              PokemonAbilitiesCard(pokemon.abilities),
              PokemonStatsCard(pokemon),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: const Icon(
                  Icons.error_outline,
                  size: 60,
                  color: Colors.red,
                ),
              ),
              Text('Error loading Pokémon: $error $stack'),
            ],
          ),
        ),
      ),
    );
  }
}
