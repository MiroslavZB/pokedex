import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex/modules/bookmarks/bookmarks_page.dart';
import 'package:pokedex/modules/pokemon_search/components/pokemon_list_card.dart';
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
    final pokemonListNotifier = ref.watch(pokemonListStateProvider.notifier);

    final pagingController = useMemoized(() => PagingController<int, PokemonListItem>(firstPageKey: 100));

    useEffect(() {
      Future.microtask(() => ref.read(pokemonListStateProvider.notifier).loadInitialPokemon());
      return null;
    }, []);

    useEffect(() {
      pokemonListState.whenData((data) {
        if (pagingController.itemList == null || pagingController.itemList!.isEmpty) {
          pagingController.value = PagingState(
            itemList: data,
            nextPageKey: pokemonListNotifier.nextPageKey,
          );
        }
      });
      return null;
    }, [pokemonListState]);

    void onPageRequest(int pageKey) async {
      try {
        final newItems = await pokemonListNotifier.getPokemonWithPagination(pageKey);
        final isLastPage = pokemonListNotifier.nextPageKey == null;

        if (isLastPage) {
          pagingController.appendLastPage(newItems);
        } else {
          pagingController.appendPage(newItems, pokemonListNotifier.nextPageKey);
        }
      } catch (error) {
        pagingController.error = error;
      }
    }

    useEffect(() {
      pagingController.addPageRequestListener(onPageRequest);
      return () => pagingController.removePageRequestListener(onPageRequest);
    }, []);

    final searchController = useSearchControllerWithDebounce(
      ref,
      pagingController.refresh,
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
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
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const WeatherRecommendationPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.wb_sunny),
                    label: const Text('Suggest Pokémon by Weather'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: pokemonListState.when(
                data: (data) {
                  if (data.isEmpty) return const Center(child: Text('No Pokémon found'));

                  return PagedListView<int, PokemonListItem>(
                    pagingController: pagingController,
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
      ),
    );
  }
}
