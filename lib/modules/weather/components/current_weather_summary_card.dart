import 'package:flutter/material.dart';
import 'package:pokedex/modules/pokemon_details/models/pokemon_type.dart';
import 'package:pokedex/shared/functions.dart';

class CurrentWeatherSummaryCard extends StatelessWidget {
  final String suggestedType;
  final String reason;

  const CurrentWeatherSummaryCard({super.key, required this.suggestedType, required this.reason});

  @override
  Widget build(BuildContext context) {
    // Create a temporary PokemonTypeInfo to get the color
    final typeInfo = PokemonTypeInfo(name: suggestedType, url: '');
    
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 20),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: typeInfo.displayColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            suggestedType.capitalizeFirst(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Flexible(
          child: Text(
            reason,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
