import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pokemon_type.g.dart';

@JsonSerializable()
class PokemonType {
  final int slot;
  @JsonKey(name: 'type')
  final PokemonTypeInfo info;

  const PokemonType({
    required this.slot,
    required this.info,
  });

  factory PokemonType.fromJson(Map<String, dynamic> json) => _$PokemonTypeFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonTypeToJson(this);
}

@JsonSerializable()
class PokemonTypeInfo {
  final String name;
  final String url;

  const PokemonTypeInfo({
    required this.name,
    required this.url,
  });

  Color get displayColor {
    switch (name.toLowerCase()) {
      case 'normal':
        return Colors.grey;
      case 'fire':
        return Colors.orange;
      case 'water':
        return Colors.blue;
      case 'electric':
        return Colors.yellow;
      case 'grass':
        return Colors.green;
      case 'ice':
        return Colors.cyan;
      case 'fighting':
        return Colors.red;
      case 'poison':
        return Colors.purple;
      case 'ground':
        return Colors.brown;
      case 'flying':
        return Colors.indigo;
      case 'psychic':
        return Colors.pink;
      case 'bug':
        return Colors.lightGreen;
      case 'rock':
        return Colors.grey.shade700;
      case 'ghost':
        return Colors.deepPurple;
      case 'dragon':
        return Colors.deepOrange;
      case 'dark':
        return Colors.black87;
      case 'steel':
        return Colors.blueGrey;
      case 'fairy':
        return Colors.pinkAccent;
      default:
        return Colors.grey;
    }
  }

  factory PokemonTypeInfo.fromJson(Map<String, dynamic> json) => _$PokemonTypeInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonTypeInfoToJson(this);
}
