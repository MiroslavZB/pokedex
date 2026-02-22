import 'package:json_annotation/json_annotation.dart';
import 'package:pokedex/modules/pokemon_search/models/pokemon_list_item.dart';

part 'type_response.g.dart';

@JsonSerializable()
class TypeResponse {
  final int id;
  final String name;
  @JsonKey(name: 'pokemon')
  final List<TypePokemon> pokemons;

  const TypeResponse({
    required this.id,
    required this.name,
    required this.pokemons,
  });

  factory TypeResponse.fromJson(Map<String, dynamic> json) => _$TypeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TypeResponseToJson(this);
}

@JsonSerializable()
class TypePokemon {
  final int slot;
  final PokemonListItem pokemon;

  const TypePokemon({
    required this.slot,
    required this.pokemon,
  });

  factory TypePokemon.fromJson(Map<String, dynamic> json) => _$TypePokemonFromJson(json);

  Map<String, dynamic> toJson() => _$TypePokemonToJson(this);
}
