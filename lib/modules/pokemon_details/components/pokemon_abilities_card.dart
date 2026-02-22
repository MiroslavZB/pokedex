import 'package:flutter/material.dart';
import 'package:pokedex/modules/pokemon_details/components/pokemon_ability_card.dart';
import 'package:pokedex/modules/pokemon_details/models/pokemon_ability.dart';

class PokemonAbilitiesCard extends StatelessWidget {
  final List<PokemonAbility> abilities;
  const PokemonAbilitiesCard(this.abilities, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: const Text(
                'Abilities',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ...abilities.map((ability) => PokemonAbilityCard(ability)),
          ],
        ),
      ),
    );
  }
}
