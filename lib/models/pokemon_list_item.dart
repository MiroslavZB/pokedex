import 'package:json_annotation/json_annotation.dart';

part 'pokemon_list_item.g.dart';

@JsonSerializable()
class PokemonListItem {
  final String name;
  final String url;

  const PokemonListItem({
    required this.name,
    required this.url,
  });

  factory PokemonListItem.fromJson(Map<String, dynamic> json) => _$PokemonListItemFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonListItemToJson(this);
}
