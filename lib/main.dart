import 'package:flutter/material.dart';
import 'package:pokedex/root.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Color(0xFFE3350D))),
      home: const Root(),
    );
  }
}
