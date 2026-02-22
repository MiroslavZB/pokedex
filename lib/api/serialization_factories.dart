import 'package:pokedex/api/serializable_converter.dart';
import 'package:pokedex/models/pokemon_ability.dart';
import 'package:pokedex/models/pokemon_detail.dart';
import 'package:pokedex/models/pokemon_list_item.dart';
import 'package:pokedex/models/pokemon_list_response.dart';
import 'package:pokedex/models/pokemon_sprite.dart';
import 'package:pokedex/models/pokemon_stat.dart';
import 'package:pokedex/models/pokemon_type.dart';

final Map<Type, JsonFactory> serializationFactories = {
  PokemonListResponse: (json) => PokemonListResponse.fromJson(json),
  PokemonListItem: (json) => PokemonListItem.fromJson(json),
  PokemonDetail: (json) => PokemonDetail.fromJson(json),
  PokemonSprite: (json) => PokemonSprite.fromJson(json),
  OtherSprites: (json) => OtherSprites.fromJson(json),
  OfficialArtwork: (json) => OfficialArtwork.fromJson(json),
  PokemonType: (json) => PokemonType.fromJson(json),
  PokemonTypeInfo: (json) => PokemonTypeInfo.fromJson(json),
  PokemonStat: (json) => PokemonStat.fromJson(json),
  StatInfo: (json) => StatInfo.fromJson(json),
  PokemonAbility: (json) => PokemonAbility.fromJson(json),
  AbilityInfo: (json) => AbilityInfo.fromJson(json),
};
