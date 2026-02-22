import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokedex/modules/pokemon_search/state/pokemon_list_state.dart';

TextEditingController useSearchControllerWithDebounce(
  WidgetRef ref, {
  required void Function() refreshPagingController,
}) {
  final searchController = useTextEditingController();
  final debounceTimer = useRef<Timer?>(null);

  final pokemonListNotifier = ref.watch(pokemonListStateProvider.notifier);

  useEffect(() {
    void onSearchChanged() {
      debounceTimer.value?.cancel();
      debounceTimer.value = Timer(const Duration(milliseconds: 500), () async {
        final query = searchController.text.trim();
        if (query.isEmpty) {
          final currentCount = ref.read(pokemonListStateProvider).valueOrNull?.length;
          if (currentCount != null && currentCount == 100) return;

          await pokemonListNotifier.loadInitialPokemon();
          refreshPagingController();
        } else {
          await pokemonListNotifier.searchPokemon(query);
          refreshPagingController();
        }
      });
    }

    searchController.addListener(onSearchChanged);
    return () {
      debounceTimer.value?.cancel();
      searchController.removeListener(onSearchChanged);
    };
  }, []);

  return searchController;
}
