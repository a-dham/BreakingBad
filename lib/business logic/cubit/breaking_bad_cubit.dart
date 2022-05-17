// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import '../../data/models/characters_model.dart';
import '../../data/models/quotes_model.dart';
import 'package:meta/meta.dart';

import '../../data/repository/character_repository.dart';

part 'breaking_bad_state.dart';

class BreakingBadCubit extends Cubit<BreakingBadState> {
  final CharacterRepository characterRepository;
  List<CharactersModel> characters = [];
  List<QuoteModel> quotes = [];

  BreakingBadCubit(
    this.characterRepository,
  ) : super(BreakingBadInitial());

  List<CharactersModel> getAllCharacter() {
    characterRepository.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters: characters));

      this.characters = characters;
    });
    return characters;
  }

  List<QuoteModel> getQuote(String charName) {
    characterRepository.getAllQuotes(charName).then(
      (quotes) {
        emit(
          QuotesLoaded(quotes: quotes),
        );
        this.quotes = quotes;
      },
    );
    return quotes;
  }

  // checkInterNet() async {
  //   try {
  //     final result = await InternetAddress.lookup('google.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       print('=====================\nconnected');
  //       emit(CheckInterNet(isConnected: true));
  //     }
  //   } on SocketException catch (_) {
  //     print('=====================\nnot connected');
  //     emit(CheckInterNet(isConnected: false));
  //   }
  // }
}
