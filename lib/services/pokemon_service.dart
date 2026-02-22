import 'package:chopper/chopper.dart';
import 'package:pokedex/models/pokemon_detail.dart';
import 'package:pokedex/models/pokemon_list_response.dart';

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

  static PokemonService create([ChopperClient? client]) => _$PokemonService(client);
}
