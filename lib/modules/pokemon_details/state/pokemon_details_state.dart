import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokedex/modules/pokemon_details/models/pokemon_detail.dart';
import 'package:pokedex/services/pokemon_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pokemon_details_state.g.dart';

@riverpod
Future<PokemonDetail> pokemonDetailsState(Ref ref, String nameOrId) =>
    PokemonService.create(ref.read(chopperPokedexProvider)).getPokemonDetail(nameOrId).parseResponse;
