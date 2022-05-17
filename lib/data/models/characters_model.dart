// To parse this JSON data, do
//
//     final charactersModel = charactersModelFromJson(jsonString);

// ignore_for_file: constant_identifier_names, unnecessary_null_comparison

import 'dart:convert';

List<CharactersModel> charactersModelFromJson(String str) =>
    List<CharactersModel>.from(
        json.decode(str).map((x) => CharactersModel.fromJson(x)));

String charactersModelToJson(List<CharactersModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CharactersModel {
  CharactersModel({
    required this.charId,
    required this.name,
    required this.birthday,
    required this.occupation,
    required this.img,
    required this.status,
    required this.nickname,
    required this.appearance,
    required this.portrayed,
    required this.category,
    required this.betterCallSaulAppearance,
  });

  int charId;
  String name;
  String birthday;
  List<String> occupation;
  String img;
  String status;
  String nickname;
  List<int> appearance;
  String portrayed;
  String category;
  List<int> betterCallSaulAppearance;

  factory CharactersModel.fromJson(Map<String, dynamic> json) =>
      CharactersModel(
        charId: json["char_id"],
        name: json["name"],
        birthday: json["birthday"],
        occupation: List<String>.from(json["occupation"].map((x) => x)),
        img: json["img"],
        status: json["status"],
        nickname: json["nickname"],
        appearance: List<int>.from(json["appearance"].map((x) => x)),
        portrayed: json["portrayed"],
        category: json["category"],
        betterCallSaulAppearance:
            List<int>.from(json["better_call_saul_appearance"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "char_id": charId,
        "name": name,
        "birthday": birthdayValues.reverse[birthday],
        "occupation": List<dynamic>.from(occupation.map((x) => x)),
        "img": img,
        "status": statusValues.reverse[status],
        "nickname": nickname,
        "appearance": List<dynamic>.from(appearance.map((x) => x)),
        "portrayed": portrayed,
        "category": categoryValues.reverse[category],
        "better_call_saul_appearance":
            List<dynamic>.from(betterCallSaulAppearance.map((x) => x)),
      };
}

enum Birthday {
  THE_09071958,
  THE_09241984,
  THE_08111970,
  THE_07081993,
  UNKNOWN
}

final birthdayValues = EnumValues({
  "07-08-1993": Birthday.THE_07081993,
  "08-11-1970": Birthday.THE_08111970,
  "09-07-1958": Birthday.THE_09071958,
  "09-24-1984": Birthday.THE_09241984,
  "Unknown": Birthday.UNKNOWN
});

enum Category { BREAKING_BAD, BREAKING_BAD_BETTER_CALL_SAUL, BETTER_CALL_SAUL }

final categoryValues = EnumValues({
  "Better Call Saul": Category.BETTER_CALL_SAUL,
  "Breaking Bad": Category.BREAKING_BAD,
  "Breaking Bad, Better Call Saul": Category.BREAKING_BAD_BETTER_CALL_SAUL
});

enum Status { PRESUMED_DEAD, ALIVE, DECEASED, UNKNOWN }

final statusValues = EnumValues({
  "Alive": Status.ALIVE,
  "Deceased": Status.DECEASED,
  "Presumed dead": Status.PRESUMED_DEAD,
  "Unknown": Status.UNKNOWN
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    // ignore: prefer_conditional_assignment
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => MapEntry(v, k));
    }
    return reverseMap!;
  }
}
