// To parse this JSON data, do
//
//     final allCountriesModel = allCountriesModelFromJson(jsonString);

import 'dart:convert';

List<AllCountriesModel> allCountriesModelFromJson(String str) => List<AllCountriesModel>.from(json.decode(str).map((x) => AllCountriesModel.fromJson(x)));

String allCountriesModelToJson(List<AllCountriesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllCountriesModel {
  AllCountriesModel({
    this.name,
    this.native,
    this.emoji,
    this.currency,
    this.languages,
  });

  String? name;
  String? native;
  String? emoji;
  String? currency;
  List<Language>? languages;

  factory AllCountriesModel.fromJson(Map<String, dynamic> json) => AllCountriesModel(
    name: json["name"],
    native: json["native"],
    emoji: json["emoji"],
    currency: json["currency"] == null ? null : json["currency"],
    languages: List<Language>.from(json["languages"].map((x) => Language.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "native": native,
    "emoji": emoji,
    "currency": currency == null ? null : currency,
    "languages": List<dynamic>.from(languages!.map((x) => x.toJson())),
  };
}

class Language {
  Language({
    this.code,
    this.name,
  });

  String? code;
  String? name;

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    code: json["code"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "name": name,
  };
}
