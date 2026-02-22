import 'package:flutter/material.dart';
import 'package:pokedex/shared/functions.dart';

class CurrentWeatherSummaryCard extends StatelessWidget {
  final String suggestedType;
  final String reason;

  const CurrentWeatherSummaryCard({super.key, required this.suggestedType, required this.reason});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 20),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _getTypeColor(suggestedType),
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

Color _getTypeColor(String typeName) {
  final typeColors = {
    'normal': const Color(0xFFA8A878),
    'fire': const Color(0xFFF08030),
    'water': const Color(0xFF6890F0),
    'electric': const Color(0xFFF8D030),
    'grass': const Color(0xFF78C850),
    'ice': const Color(0xFF98D8D8),
    'fighting': const Color(0xFFC03028),
    'poison': const Color(0xFFA040A0),
    'ground': const Color(0xFFE0C068),
    'flying': const Color(0xFFA890F0),
    'psychic': const Color(0xFFF85888),
    'bug': const Color(0xFFA8B820),
    'rock': const Color(0xFFB8A038),
    'ghost': const Color(0xFF705898),
    'dragon': const Color(0xFF7038F8),
    'dark': const Color(0xFF705848),
    'steel': const Color(0xFFB8B8D0),
    'fairy': const Color(0xFFEE99AC),
  };

  return typeColors[typeName.toLowerCase()] ?? Colors.grey;
}
