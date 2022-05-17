part of 'breaking_bad_cubit.dart';

@immutable
abstract class BreakingBadState {}

class BreakingBadInitial extends BreakingBadState {}

class CharactersLoaded extends BreakingBadState {
  final List<CharactersModel> characters;
  CharactersLoaded({
    required this.characters,
  });
}

class QuotesLoaded extends BreakingBadState {
  final List<QuoteModel> quotes;
  QuotesLoaded({
    required this.quotes,
  });
}

// class CheckInterNet extends BreakingBadState {
//   final bool isConnected;
//   CheckInterNet({
//     required this.isConnected,
//   });
// }
