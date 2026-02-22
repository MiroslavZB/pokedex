import 'package:pokedex/api/serializable_converter.dart';
import 'package:pokedex/modules/pokemon_details/models/pokemon_ability.dart';
import 'package:pokedex/modules/pokemon_details/models/pokemon_detail.dart';
import 'package:pokedex/modules/pokemon_details/models/pokemon_sprite.dart';
import 'package:pokedex/modules/pokemon_details/models/pokemon_stat.dart';
import 'package:pokedex/modules/pokemon_details/models/pokemon_type.dart';
import 'package:pokedex/modules/pokemon_details/models/type_response.dart';
import 'package:pokedex/modules/pokemon_search/components/pokemon_list_response.dart';
import 'package:pokedex/modules/pokemon_search/models/pokemon_list_item.dart';
import 'package:pokedex/modules/weather/models/weather_response.dart';

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
  TypeResponse: (json) => TypeResponse.fromJson(json),
  TypePokemon: (json) => TypePokemon.fromJson(json),
  WeatherResponse: (json) => WeatherResponse.fromJson(json),
  CurrentWeather: (json) => CurrentWeather.fromJson(json),
};
