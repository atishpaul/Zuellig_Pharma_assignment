import 'package:ezcountries/controllers/countries_controller.dart';
import 'package:ezcountries/widgets/search_bar.dart';
import 'package:ezcountries/widgets/search_tile.dart';
import 'package:ezcountries/widgets/tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final countrylistener = Get.put(CountriesController());

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Obx(() => Column(
              children: [
                const MySearchBar(),
                countrylistener.isSubmitted.value == false
                    ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Filter by language : ',
                            style: TextStyle(fontSize: 15),
                          ),
                          InkWell(
                            onTap: () {
                              countrylistener.filter.value = "Hindi";
                              countrylistener.filterLanguage("Hindi");
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: countrylistener.filter.value == 'Hindi' ? Colors.green : Colors.black12,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4),
                                    child: Text(
                                      'Hindi',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              countrylistener.filter.value = "English";
                              countrylistener.filterLanguage("English");
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: countrylistener.filter.value == 'English' ? Colors.orangeAccent : Colors.black12,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4),
                                    child: Text(
                                      'English',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          countrylistener.filter.value != 'All' ? InkWell(
                            onTap: () {
                              countrylistener.retrainStoredCountryData();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.pink,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4),
                                    child: Text(
                                      'Clear',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )),
                            ),
                          ):Row(),
                        ],
                      )
                    ],
                  ),
                ):Row(),
                countrylistener.isSubmitted.value == false
                    ? Expanded(
                        child: Scrollbar(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: countrylistener.allCountriesLists.length,
                            itemBuilder: (context, index) {
                              return MyTile(
                                index: index,
                                allCounterModelList: countrylistener.allCountriesLists,
                              );
                            },
                          ),
                        ),
                      )
                    : const SearchTile(),
              ],
            ),
        ),
      ),
    );
  }
}
