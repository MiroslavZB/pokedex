import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PokemonLoadingCard extends StatelessWidget {
  const PokemonLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Row(
            children: [
              Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 16,
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
