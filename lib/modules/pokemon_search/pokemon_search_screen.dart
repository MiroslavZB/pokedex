import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex/modules/bookmarks/bookmarks_page.dart';
import 'package:pokedex/modules/pokemon_search/components/pokemon_list_card.dart';
import 'package:pokedex/modules/pokemon_search/hooks/use_paging_controller_with_setup_and_listen.dart';
import 'package:pokedex/modules/pokemon_search/hooks/use_search_controller_with_debounce.dart';
import 'package:pokedex/modules/pokemon_search/models/pokemon_list_item.dart';
import 'package:pokedex/modules/pokemon_search/state/pokemon_list_state.dart';
import 'package:pokedex/modules/weather/weather_recommendation_page.dart';
import 'package:pokedex/shared/functions.dart';

class PokemonSearchScreen extends HookConsumerWidget {
  const PokemonSearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonListState = ref.watch(pokemonListStateProvider);

    final pagingController = usePagingControllerWithSetupAndListen(ref);

    final searchController = useSearchControllerWithDebounce(
      ref,
      refreshPagingController: pagingController.refresh,
    );

    return GestureDetector(
      onTap: unfocus,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pokédex'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            IconButton(
              icon: const Icon(Icons.bookmark),
              iconSize: 32,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BookmarksPage()),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: searchController,
                onTapOutside: (_) => unfocus(),
                decoration: InputDecoration(
                  hintText: 'Search Pokémon by name or ID...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: searchController.clear,
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Expanded(
              child: pokemonListState.when(
                data: (data) {
                  if (data.isEmpty) return const Center(child: Text('No Pokémon found'));

                  return PagedListView<int, PokemonListItem>(
                    pagingController: pagingController,
                    padding: EdgeInsets.only(bottom: 100),
                    builderDelegate: PagedChildBuilderDelegate<PokemonListItem>(
                      itemBuilder: (context, pokemon, _) => PokemonListCard(pokemon),
                      firstPageErrorIndicatorBuilder: (context) => Center(
                        child: Text('Error: ${pagingController.error}'),
                      ),
                      newPageErrorIndicatorBuilder: (context) => Center(
                        child: Text('Error: ${pagingController.error}'),
                      ),
                      noItemsFoundIndicatorBuilder: (context) => const Center(
                        child: Text('No Pokémon found'),
                      ),
                    ),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error')),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const WeatherRecommendationPage(),
            ),
          ),
          icon: const Icon(Icons.wb_sunny),
          label: const Text('Weather Pokémon Recommendation'),
          backgroundColor: Colors.orange.shade400,
          foregroundColor: Colors.white,
          elevation: 6,
        ),
      ),
    );
  }
}
