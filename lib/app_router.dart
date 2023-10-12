import 'package:blok/business_logic_layer/cubit/characters_cubit.dart';
import 'package:blok/constants/strings.dart';
import 'package:blok/data/repository/characters_repository.dart';
import 'package:blok/data/web_service/characters_web_service.dart';
import 'package:blok/presentation/screens/characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/screens/characters_datails.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebService());
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext contxt) => charactersCubit,
            child: const CharactersScreen(),
          ),
        );
      case charactersDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => const CharactersDetailsScreen());
    }
    return null;
  }
}
