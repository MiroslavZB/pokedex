import 'package:json_annotation/json_annotation.dart';
import 'package:pokedex/modules/pokemon_details/models/pokemon_ability.dart';
import 'package:pokedex/modules/pokemon_details/models/pokemon_sprite.dart';
import 'package:pokedex/modules/pokemon_details/models/pokemon_stat.dart';
import 'package:pokedex/modules/pokemon_details/models/pokemon_type.dart';
import 'package:pokedex/modules/pokemon_search/models/pokemon_list_item.dart';

part 'pokemon_detail.g.dart';

@JsonSerializable()
class PokemonDetail implements PokemonListItem {
  final int id;
  @JsonKey(name: 'name')
  final String name_;
  final int height;
  final int weight;
  final List<PokemonAbility> abilities;
  final List<PokemonType> types;
  final List<PokemonStat> stats;
  final PokemonSprite sprites;

  const PokemonDetail({
    required this.name_,
    required this.id,
    required this.height,
    required this.weight,
    required this.abilities,
    required this.types,
    required this.stats,
    required this.sprites,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) => _$PokemonDetailFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PokemonDetailToJson(this);

  @override
  String get url => 'https://pokeapi.co/api/v2/pokemon/$id/';

  @override
  String get name => name_;
}
