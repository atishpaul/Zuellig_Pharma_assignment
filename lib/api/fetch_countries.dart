import 'dart:convert';
import 'package:ezcountries/views/country_list_and_search.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/country_model.dart';
import '../models/get_all_countries_model.dart';

class GetAllCountriesApi extends GetConnect {
  List<CountryModel> data = [];
  Future<List<CountryModel>> fetchCountryBySearch(String getCode) async {
    SmartDialog.showLoading(msg: 'Getting searched results..');
    data.clear();
    try {
      var headers = {'Content-Type': 'application/json'};
      var body =
          '''{"query":"query Query {\\r\\n  country(code: \\"${getCode.toUpperCase()}\\") {\\r\\n    name\\r\\n    native\\r\\n    capital\\r\\n    emoji\\r\\n    currency\\r\\n    languages {\\r\\n      code\\r\\n      name\\r\\n    }\\r\\n  }\\r\\n}","variables":{}}''';
      final response = await http.post(Uri.parse('https://countries.trevorblades.com/graphql'), body: body, headers: headers);
      if (response.statusCode == 200) {
        final countryModel = countryModelFromJson(response.body);
        data.add(countryModel);
        return data;
      } else {
        SmartDialog.showToast('connection refused. retry!');
      }
    } on Exception catch (e) {
      print(e);
      SmartDialog.showToast('Something went wrong,check connection!');
      // TODO
    } finally {
      SmartDialog.dismiss();
      try {
        if (data[0].data!.country == null) {
          SmartDialog.showToast('No Results Found!');
        }
      } catch (e) {
        SmartDialog.showToast('No Results Found!');
        // TODO
      }
    }
    return data;
  }

  List<AllCountriesModel> data2 = [];
  Future<List<AllCountriesModel>> fetchCountries() async {
    data2.clear();
    try {
      var headers = {'Content-Type': 'application/json'};
      var body =
          '''{"query":"query ExampleQuery {\\r\\n  countries {\\r\\n    name\\r\\n    native\\r\\n    emoji\\r\\n    currency\\r\\n    languages {\\r\\n      code\\r\\n      name\\r\\n    }\\r\\n  }\\r\\n}","variables":{}}''';
      final response = await http.post(Uri.parse('https://countries.trevorblades.com/graphql'), body: body, headers: headers);
      if (response.statusCode == 200) {

        // sorting by alphabetically.
        var jsonData = jsonDecode(response.body);
        var tempList = [];
        tempList.add(jsonData);
        tempList[0]['data']['countries'].sort((a, b) => a.toString().toLowerCase().compareTo(b.toString().toLowerCase()));
        countrylistener.allCountriesListsRaw.add(tempList[0]['data']['countries']);
        // print(jsonEncode(tempList[0]['data']['countries']));
        // sorting ends here....

        final allCountriesModel = allCountriesModelFromJson(jsonEncode(tempList[0]['data']['countries']));
        countrylistener.allCountriesListsForFuture.addAll(allCountriesModel);
        if (response.body.isNotEmpty) {
          data2.addAll(allCountriesModel);
          return data2;
        } else {
          SmartDialog.showToast('No Result Found!');
        }
      } else {
        SmartDialog.showToast('connection refused. retry!');
      }
    } on Exception catch (e) {
      print(e);
      SmartDialog.showToast('Something went wrong,check connection!');
      // TODO
    }
    return data2;
  }
}