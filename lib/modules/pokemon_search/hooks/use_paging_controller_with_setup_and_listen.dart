import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex/modules/pokemon_search/models/pokemon_list_item.dart';
import 'package:pokedex/modules/pokemon_search/state/pokemon_list_state.dart';
import 'package:pokedex/shared/functions.dart';

PagingController<int, PokemonListItem> usePagingControllerWithSetupAndListen(WidgetRef ref) {
  final pokemonListState = ref.watch(pokemonListStateProvider);
  final pokemonListNotifier = ref.watch(pokemonListStateProvider.notifier);

  final pagingController = useMemoized(() => PagingController<int, PokemonListItem>(firstPageKey: 100));

  useEffect(() {
    scheduleAfterBuild(() => ref.read(pokemonListStateProvider.notifier).loadInitialPokemon());
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

  return pagingController;
}
