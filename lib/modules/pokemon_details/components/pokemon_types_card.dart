import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_type.dart';
import 'package:pokedex/shared/functions.dart';

class PokemonTypesCard extends StatelessWidget {
  final List<PokemonType> types;
  const PokemonTypesCard(this.types, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Wrap(
        spacing: 8,
        children: types
            .map(
              (type) => Chip(
                label: Text(
                  type.info.name.capitalizeFirst(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: type.info.displayColor,
              ),
            )
            .toList(),
      ),
    );
  }
}
