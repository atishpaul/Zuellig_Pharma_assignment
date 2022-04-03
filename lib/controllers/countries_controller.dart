import 'dart:convert';
import 'package:ezcountries/models/country_model.dart';
import 'package:ezcountries/models/get_all_countries_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import '../api/fetch_countries.dart';

class CountriesController extends GetxController {
  final fetchCountryInstance = Get.put(GetAllCountriesApi());

  var countries = <CountryModel>[].obs;
  var allCountriesLists = <AllCountriesModel>[].obs;
  var allCountriesListsRaw = [].obs;
  var allCountriesListsForFuture = <AllCountriesModel>[].obs;
  TextEditingController searchedText = TextEditingController();
  var hint = false.obs;
  var showlanguages = false.obs;
  var showLangIndex = 0.obs;
  var isSubmitted = false.obs;
  var filter = "All".obs;

  void hintState(bool hintData) {
    hint.value = hintData;
  }

  void switchHintText() {
    hint.value = true;
  }

  // get Country by user search
  List<CountryModel> getCountrySearch(String countryCode) {
    countries.clear();
    fetchCountryInstance.fetchCountryBySearch(countryCode).then((value) {
      if (value.isNotEmpty) {
        countries.add(value[0]);
      } else {
        SmartDialog.showToast('No Result Found!');
      }
    });
    return countries;
  }

  // fetching all country data.
  Future<List<AllCountriesModel>> getAllCountryList() async {
    allCountriesLists.clear();
    await fetchCountryInstance.fetchCountries().then((value) {
      if (value.isNotEmpty) {
        allCountriesLists.addAll(value);
      }
    });
    return allCountriesLists;
  }

  // filtering by country language
  void filterLanguage(String language) {
    List tempList = [];
    allCountriesLists.clear();
    for (var element1 in allCountriesListsForFuture) {
      for (var element2 in element1.languages!) {
        if (language == element2.name.toString()) {
          tempList.add({
            "name": element1.name,
            "native": element1.native,
            "emoji": element1.emoji,
            "currency": element1.currency,
            "languages": [
              {"code": element2.code, "name": element2.name}
            ]
          });
        }
      }
    }
    final allCountriesModel = allCountriesModelFromJson(jsonEncode(tempList));
    allCountriesLists.addAll(allCountriesModel);
  }

  // assigning old country data.
  void retrainStoredCountryData() {
    filter.value = 'All';
    allCountriesLists.clear();
    allCountriesLists.addAll(allCountriesListsForFuture);
  }
}
