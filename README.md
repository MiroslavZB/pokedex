# Pokédex

A Flutter app that helps you search for Pokémon using the public PokéAPI.

## Features

- Search Pokémon by name or ID
- Infinite scroll pagination through all Pokémon
- View detailed stats, abilities, types, height, and weight
- Color-coded type badges
- Clean Material Design 3 UI

## Setup Instructions

### Prerequisites

- Flutter and Dart SDK (3.10.0 or higher)

### Installation

1. Clone the repository and navigate to the project directory

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Generate required code files:
   ```bash
   dart run build_runner build --d
   ```


## Tech Stack

- **State Management**: Riverpod with code generation
- **API Client**: Chopper with custom serialization
- **Pagination**: infinite_scroll_pagination
- **Code Generation**: build_runner, json_serializable, chopper_generator, riverpod_generator


## API

This app uses the [PokéAPI](https://pokeapi.co/) - a free RESTful Pokémon API.

