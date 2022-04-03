import 'dart:convert';

CountryModel countryModelFromJson(String str) => CountryModel.fromJson(json.decode(str));

String countryModelToJson(CountryModel data) => json.encode(data.toJson());

class CountryModel {
  CountryModel({
    this.data,
  });

  Data? data;

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.country,
  });

  Country? country;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    country: Country.fromJson(json["country"]),
  );

  Map<String, dynamic> toJson() => {
    "country": country!.toJson(),
  };
}

class Country {
  Country({
    this.name,
    this.native,
    this.capital,
    this.emoji,
    this.currency,
    this.languages,
  });

  String? name;
  String? native;
  String? capital;
  String? emoji;
  String? currency;
  List<Language>? languages;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    name: json["name"],
    native: json["native"],
    capital: json["capital"],
    emoji: json["emoji"],
    currency: json["currency"],
    languages: List<Language>.from(json["languages"].map((x) => Language.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "native": native,
    "capital": capital,
    "emoji": emoji,
    "currency": currency,
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
