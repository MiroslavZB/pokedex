import 'package:json_annotation/json_annotation.dart';

part 'pokemon_sprite.g.dart';

@JsonSerializable()
class PokemonSprite {
  @JsonKey(name: 'front_default')
  final String? frontDefault;
  @JsonKey(name: 'front_shiny')
  final String? frontShiny;
  @JsonKey(name: 'back_default')
  final String? backDefault;
  final OtherSprites? other;

  const PokemonSprite({
    this.frontDefault,
    this.frontShiny,
    this.backDefault,
    this.other,
  });

  factory PokemonSprite.fromJson(Map<String, dynamic> json) => _$PokemonSpriteFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonSpriteToJson(this);
}

@JsonSerializable()
class OtherSprites {
  @JsonKey(name: 'official-artwork')
  final OfficialArtwork? officialArtwork;

  const OtherSprites({
    this.officialArtwork,
  });

  factory OtherSprites.fromJson(Map<String, dynamic> json) => _$OtherSpritesFromJson(json);

  Map<String, dynamic> toJson() => _$OtherSpritesToJson(this);
}

@JsonSerializable()
class OfficialArtwork {
  @JsonKey(name: 'front_default')
  final String? frontDefault;

  const OfficialArtwork({
    this.frontDefault,
  });

  factory OfficialArtwork.fromJson(Map<String, dynamic> json) => _$OfficialArtworkFromJson(json);

  Map<String, dynamic> toJson() => _$OfficialArtworkToJson(this);
}
