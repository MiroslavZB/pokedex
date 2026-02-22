import 'package:pokedex/models/pokemon_list_item.dart';
import 'package:pokedex/services/pokemon_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pokemon_list_state.g.dart';

@Riverpod(keepAlive: true)
class PokemonListState extends _$PokemonListState {
  late PokemonService _pokemonService;
  int? nextPageKey = 0;
  String _searchQuery = '';
  static const int _limit = 100;

  @override
  Future<List<PokemonListItem>> build() async {
    _pokemonService = PokemonService.create(ref.read(chopperPokedexProvider));
    return [];
  }

  Future<void> loadInitialPokemon() async {
    _pokemonService = PokemonService.create(ref.read(chopperPokedexProvider));

    nextPageKey = 0;
    _searchQuery = '';
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final response = await _pokemonService.getPokemonList(limit: _limit, offset: 0).parseResponse;
      nextPageKey = 100;
      return response.results;
    });
  }

  Future<List<PokemonListItem>> getPokemonWithPagination(int pageKey) async {
    final response = await _pokemonService.getPokemonList(limit: _limit, offset: pageKey).parseResponse;

    if (response.results.isEmpty) {
      nextPageKey = null;
      return [];
    }

    nextPageKey = pageKey + _limit;
    return response.results;
  }

  Future<void> searchPokemon(String query) async {
    _searchQuery = query.toLowerCase().trim();

    if (_searchQuery.isEmpty) {
      await loadInitialPokemon();
      return;
    }

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      try {
        final detail = await _pokemonService.getPokemonDetail(_searchQuery).parseResponse;

        nextPageKey = null;
        return [detail];
      } catch (e) {
        nextPageKey = null;
        return [];
      }
    });
  }

  void resetNextPageKey() => nextPageKey = 0;
}
