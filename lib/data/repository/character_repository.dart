import '../models/characters_model.dart';
import '../models/quotes_model.dart';
import '../web%20services/character_services.dart';

class CharacterRepository {
  final CharacterServices characterServices;
  CharacterRepository({
    required this.characterServices,
  });

  Future<List<CharactersModel>> getAllCharacters() async {
    final characters = await characterServices.getAllCharacter();
    return characters
        .map((character) => CharactersModel.fromJson(character))
        .toList();
  }

  Future<List<QuoteModel>> getAllQuotes(String charName) async {
    final quotes = await characterServices.getQuotes(charName);
    return quotes
        .map(
          (quote) => QuoteModel.fromJson(quote),
        )
        .toList();
  }
}
