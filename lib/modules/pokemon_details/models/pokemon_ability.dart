import 'package:json_annotation/json_annotation.dart';

part 'pokemon_ability.g.dart';

@JsonSerializable()
class PokemonAbility {
  @JsonKey(name: 'is_hidden')
  final bool isHidden;
  final int slot;
  final AbilityInfo ability;

  const PokemonAbility({
    required this.isHidden,
    required this.slot,
    required this.ability,
  });

  factory PokemonAbility.fromJson(Map<String, dynamic> json) => _$PokemonAbilityFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonAbilityToJson(this);
}

@JsonSerializable()
class AbilityInfo {
  final String name;
  final String url;

  const AbilityInfo({
    required this.name,
    required this.url,
  });

  factory AbilityInfo.fromJson(Map<String, dynamic> json) => _$AbilityInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AbilityInfoToJson(this);
}
