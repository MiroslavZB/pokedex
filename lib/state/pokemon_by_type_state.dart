import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokedex/modules/pokemon_details/models/pokemon_detail.dart';
import 'package:pokedex/services/pokemon_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pokemon_by_type_state.g.dart';

@riverpod
Future<PokemonDetail> pokemonByType(Ref ref, String typeName) async {
  final pokemonService = PokemonService.create(ref.read(chopperPokedexProvider));

  // Fetch all Pokemon of this type
  final typeResponse = await pokemonService.getType(typeName).parseResponse;

  if (typeResponse.pokemons.isEmpty) {
    throw Exception('No Pokémon found for type: $typeName');
  }

  // Pick a random Pokemon from the first 30% (more common ones)
  final randomIndex = Random().nextInt((typeResponse.pokemons.length * 0.3).toInt());
  final selectedPokemon = typeResponse.pokemons[randomIndex].pokemon;

  // Fetch the full Pokemon details
  final pokemonDetail = await pokemonService.getPokemonDetail(selectedPokemon.name).parseResponse;

  return pokemonDetail;
}
