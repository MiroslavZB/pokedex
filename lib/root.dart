import 'package:flutter/material.dart';
import 'package:pokedex/modules/pokemon_search/pokemon_search_screen.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    // Left like this for a potential tab-view/bottom-nav-bar implementation
    return const PokemonSearchScreen();
  }
}
