import 'package:pokedex/models/pokemon_detail.dart';
import 'package:pokedex/services/storage_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookmarks_state.g.dart';

@Riverpod(keepAlive: true)
class BookmarksState extends _$BookmarksState {
  @override
  List<PokemonDetail> build() {
    final bookmarks = StorageService.getBookmarks();
    return bookmarks;
  }

  void addBookmark(PokemonDetail pokemon) {
    StorageService.addBookmark(pokemon);
    state = StorageService.getBookmarks();
  }

  void removeBookmark(int pokemonId) {
    StorageService.removeBookmark(pokemonId);
    state = StorageService.getBookmarks();
  }

  bool isBookmarked(int pokemonId) {
    final bookmarked = state.any((p) => p.id == pokemonId);
    return bookmarked;
  }

  void toggleBookmark(PokemonDetail pokemon) {
    if (isBookmarked(pokemon.id)) {
      removeBookmark(pokemon.id);
    } else {
      addBookmark(pokemon);
    }
  }
}
