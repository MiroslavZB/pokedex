import 'package:chopper/chopper.dart';
import 'package:pokedex/modules/pokemon_details/models/pokemon_detail.dart';
import 'package:pokedex/modules/pokemon_details/models/type_response.dart';
import 'package:pokedex/modules/pokemon_search/components/pokemon_list_response.dart';

export 'package:pokedex/api/client.dart';
export 'package:pokedex/api/extensions/parse_response.dart';

part 'pokemon_service.chopper.dart';

@ChopperApi(baseUrl: '/pokemon')
abstract class PokemonService extends ChopperService {
  @GET()
  Future<Response<PokemonListResponse>> getPokemonList({
    @Query('limit') required int limit,
    @Query('offset') int offset = 0,
  });

  @GET(path: '/{nameOrId}')
  Future<Response<PokemonDetail>> getPokemonDetail(@Path('nameOrId') String nameOrId);

  @GET(path: '/../type/{typeName}')
  Future<Response<TypeResponse>> getType(@Path('typeName') String typeName);

  static PokemonService create([ChopperClient? client]) => _$PokemonService(client);
}
