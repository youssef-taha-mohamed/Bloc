import 'package:blok/data/models/characters.dart';
import 'package:blok/data/web_service/characters_web_service.dart';

class CharactersRepository {
  final CharactersWebService charactersWebService;

  CharactersRepository(this.charactersWebService);

  Future<List<Character>> getAllCharacters() async {
    final characters = await charactersWebService.getAllCharacters();

    return characters.map((e) => Character.fromJson(e)).toList();
  }
}
