import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_ability.dart';
import 'package:pokedex/shared/functions.dart';

class PokemonAbilityCard extends StatelessWidget {
  final PokemonAbility ability;
  const PokemonAbilityCard(this.ability, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(
              ability.isHidden ? Icons.visibility_off : Icons.check_circle,
              size: 20,
              color: ability.isHidden ? Colors.grey : Colors.green,
            ),
          ),
          Flexible(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: ability.ability.name.replaceAll('-', ' ').capitalizeFirst(),
                  ),
                  if (ability.isHidden)
                    TextSpan(
                      text: ' (Hidden)',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
