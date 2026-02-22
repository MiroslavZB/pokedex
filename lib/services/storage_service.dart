import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:pokedex/modules/pokemon_details/models/pokemon_detail.dart';

abstract class StorageService {
  static final GetStorage _storage = GetStorage();
  static const String _bookmarksKey = 'bookmarkedPokemon';

  static List<PokemonDetail> getBookmarks() {
    final list = _storage.read<List<dynamic>?>(_bookmarksKey);

    if (list == null) return [];

    try {
      final bookmarks = list.map((e) => PokemonDetail.fromJson(e)).toList();
      return bookmarks;
    } catch (e) {
      log('Error parsing bookmarks: $e');
      return [];
    }
  }

  static void saveBookmarks(List<PokemonDetail> bookmarks) {
    _storage.write(_bookmarksKey, bookmarks.map((e) => e.toJson()).toList());
  }

  static void addBookmark(PokemonDetail pokemon) {
    final bookmarks = getBookmarks();
    if (!bookmarks.any((p) => p.id == pokemon.id)) {
      bookmarks.add(pokemon);
      saveBookmarks(bookmarks);
    } else {
      log('Pokemon already bookmarked');
    }
  }

  static void removeBookmark(int pokemonId) {
    final bookmarks = getBookmarks();
    bookmarks.removeWhere((p) => p.id == pokemonId);
    saveBookmarks(bookmarks);
  }

  static bool isBookmarked(int pokemonId) {
    final bookmarks = getBookmarks();
    return bookmarks.any((p) => p.id == pokemonId);
  }

  static void clearBookmarks() => _storage.remove(_bookmarksKey);
}
