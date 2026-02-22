import 'package:json_annotation/json_annotation.dart';

part 'pokemon_stat.g.dart';

@JsonSerializable()
class PokemonStat {
  @JsonKey(name: 'base_stat')
  final int baseStat;
  final int effort;
  @JsonKey(name: 'stat')
  final StatInfo info;

  const PokemonStat({
    required this.baseStat,
    required this.effort,
    required this.info,
  });

  factory PokemonStat.fromJson(Map<String, dynamic> json) => _$PokemonStatFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonStatToJson(this);
}

@JsonSerializable()
class StatInfo {
  final String name;
  final String url;

  const StatInfo({
    required this.name,
    required this.url,
  });

  factory StatInfo.fromJson(Map<String, dynamic> json) => _$StatInfoFromJson(json);

  Map<String, dynamic> toJson() => _$StatInfoToJson(this);
}
