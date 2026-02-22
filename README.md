# Pokédex

A Flutter app that helps you search for Pokémon using the public PokéAPI.

## Features

- Search Pokémon by name or ID
- Infinite scroll pagination through all Pokémon
- View pokemon details

## Setup Instructions

### Prerequisites

- Flutter and Dart SDK (3.10.0 or higher)

### Installation

1. Install dependencies:
   ```bash
   flutter pub get
   ```

2. Generate required code files:
   ```bash
   dart run build_runner build --d
   ```


## Tech Stack

- **State Management**: Riverpod with code generation
- **API Client**: Chopper with custom serialization
- **Pagination**: infinite_scroll_pagination
- **Code Generation**: build_runner, json_serializable, chopper_generator, riverpod_generator


## Known issues and improvements

1. Some pokemons don't have sprites and therefore their image won't appear in the list view but 
   will appear in details screen
   - Solution here is either to: 1) fetch all 1350 pokemons once, store them locally, and have 
     all the data already which removes the need for all future API calls. Or 2) for the 
     specific pokemons only, fetch the data. 
2. Pokemon type doesn't appear in the list view either because it is only part of the details 
   response, and in order to not call the api for all the elements in the view, they are not 
   shown here
   - Solution once again is either same as solution 1) for the point above, or to fetch lazily for 
     all elements that are in the "view", i.e. all drawn widgets from the list  
3. Clicking on weather recommendations is hard-coded for Tokyo
4. Sometimes, when you click on weather recommendations button you will get a miss-match between 
   the recommended type and the type (the primary type i.e. the first one) of the pokemon shown 
   on the card. This is because we show only one of the types, but one of the other types did 
   actually match the type needed for the weather
5. I am not sure how hidden abilities are supposed to work, the pokedex website doesn't show 
   them, i decided to just note that they are there but are hidden.
6. you can also search for ID (i.e. searching 25 returns pikachu!)
7. you can't search for partial names. only exact, case-insensitive results will match. This is 
   because the API doesn't return anything for partial matches as it is a GET resource request 
   instead of a look-up
   - Solution here is to 1) again, do the look-up locally by pre-fetching all 1350 results. Or 2)
     if this was our own backend, we could make a lookup instead
