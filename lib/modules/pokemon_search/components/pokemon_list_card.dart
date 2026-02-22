import 'package:flutter/material.dart';
import 'package:pokedex/modules/pokemon_details/models/pokemon_detail.dart';
import 'package:pokedex/modules/pokemon_search/models/pokemon_list_item.dart';
import 'package:pokedex/modules/pokemon_details/pokemon_details_page.dart';
import 'package:pokedex/shared/functions.dart';

class PokemonListCard extends StatelessWidget {
  final PokemonListItem pokemon;

  const PokemonListCard(this.pokemon, {super.key});

  String _getPokemonId(String url) {
    final parts = url.split('/');
    return parts[parts.length - 2];
  }

  @override
  Widget build(BuildContext context) {
    final pokemonId = _getPokemonId(pokemon.url);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Image.network(
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$pokemonId.png',
          width: 60,
          height: 60,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.catching_pokemon, size: 60),
        ),
        title: Text(
          pokemon.name.capitalizeFirst(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('#$pokemonId'),
            if (pokemon is PokemonDetail)
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: Text('Primary Type:'),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: (pokemon as PokemonDetail).types.first.info.displayColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      (pokemon as PokemonDetail).types.first.info.name.capitalizeFirst(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PokemonDetailsPage(
              pokemonName: pokemon.name,
            ),
          ),
        ),
      ),
    );
  }
}
