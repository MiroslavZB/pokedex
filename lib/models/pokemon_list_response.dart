import 'package:json_annotation/json_annotation.dart';
import 'package:pokedex/models/pokemon_list_item.dart';

part 'pokemon_list_response.g.dart';

@JsonSerializable()
class PokemonListResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<PokemonListItem> results;

  const PokemonListResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory PokemonListResponse.fromJson(Map<String, dynamic> json) => _$PokemonListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonListResponseToJson(this);
}
