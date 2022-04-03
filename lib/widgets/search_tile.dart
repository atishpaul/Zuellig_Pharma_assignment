import 'package:ezcountries/controllers/countries_controller.dart';
import 'package:ezcountries/views/country_list_and_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchTile extends StatefulWidget {
  const SearchTile({Key? key}) : super(key: key);

  @override
  State<SearchTile> createState() => _SearchTileState();
}

class _SearchTileState extends State<SearchTile> {
  @override
  Widget build(BuildContext context) {
    return GetX<CountriesController>(
      builder: (controller) {
        if (controller.countries.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25),
            child: Column(
              children: [
                Container(
                  color: const Color(0xFFF7F5F2),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            controller.countries[0].data!.country!.name.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            " (" + controller.countries[0].data!.country!.currency.toString() + ")",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            controller.countries[0].data!.country!.capital.toString(),
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            controller.countries[0].data!.country!.native.toString(),
                            style: const TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              if (countrylistener.showlanguages.value) {
                                countrylistener.showlanguages.value = false;
                              } else {
                                countrylistener.showlanguages.value = true;
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFEAEA7F),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                                    child: Row(
                                      children: const [
                                        Text('Languages'),
                                        Icon(
                                          Icons.arrow_downward_rounded,
                                          size: 22,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      countrylistener.showlanguages.value
                          ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: controller.countries[0].data!.country!.languages!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index2) => Row(
                            children: [
                              Text(
                                "${index2 + 1}.",
                                style: const TextStyle(fontSize: 17, color: Colors.black54),
                              ),
                              Text(
                                controller.countries[0].data!.country!.languages![index2].name.toString(),
                                style: const TextStyle(fontSize: 17, color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                      )
                          : Row(),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          countrylistener.isSubmitted.value = false;
                          countrylistener.searchedText.clear();
                        },
                        borderRadius: BorderRadius.circular(25),
                        child: Ink(
                          decoration: BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                            child: Text(
                              'clear',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        } else {
          return Row();
        }
      },
    );
  }
}

