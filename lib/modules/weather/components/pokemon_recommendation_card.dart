import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokedex/modules/pokemon_details/models/pokemon_detail.dart';
import 'package:pokedex/modules/pokemon_details/pokemon_details_page.dart';
import 'package:pokedex/shared/functions.dart';
import 'package:pokedex/state/bookmarks_state.dart';

class PokemonRecommendationCard extends ConsumerWidget {
  final PokemonDetail pokemon;

  const PokemonRecommendationCard({
    super.key,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarksNotifier = ref.watch(bookmarksStateProvider.notifier);
    final isBookmarked = ref.watch(bookmarksStateProvider).contains(pokemon);

    final primaryType = pokemon.types.isNotEmpty ? pokemon.types.first.info : null;
    final imageUrl = pokemon.sprites.other?.officialArtwork?.frontDefault ?? pokemon.sprites.frontDefault;

    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PokemonDetailsPage(pokemonName: pokemon.name),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  if (imageUrl != null)
                    Image.network(
                      imageUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.catching_pokemon,
                        size: 100,
                      ),
                    )
                  else
                    const Icon(Icons.catching_pokemon, size: 100),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pokemon.name.capitalizeFirst(),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '#${pokemon.id}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          if (primaryType != null)
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: primaryType.displayColor,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                primaryType.name.capitalizeFirst(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_border),
                    iconSize: 32,
                    onPressed: () => bookmarksNotifier.toggleBookmark(pokemon),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
