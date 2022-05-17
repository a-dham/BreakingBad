import 'data/models/characters_model.dart';
import 'data/web%20services/character_services.dart';
import 'presentation/screens/characters.dart';
import 'package:flutter/material.dart';

import 'business%20logic/cubit/breaking_bad_cubit.dart';
import 'constant/strings.dart';
import 'data/repository/character_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/screens/character_details.dart';

class AppRouter {
  late CharacterRepository characterRepository;
  late BreakingBadCubit breakingBadCubit;
  AppRouter() {
    characterRepository =
        CharacterRepository(characterServices: CharacterServices());
    breakingBadCubit = BreakingBadCubit(characterRepository);
  }

  Route? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case charactersScreen:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) => breakingBadCubit,
            child: const CharactersScreen(),
          );
        });
      case charactersDetailsScreen:
        final character = routeSettings.arguments as CharactersModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => breakingBadCubit,
            child: CharacterDetails(
              character: character,
            ),
          ),
        );
    }
    return null;
  }
}
