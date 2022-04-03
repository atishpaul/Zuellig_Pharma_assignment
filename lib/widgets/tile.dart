import 'package:ezcountries/models/get_all_countries_model.dart';
import 'package:ezcountries/views/country_list_and_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTile extends StatefulWidget {
  final int index;
  final RxList<AllCountriesModel>? allCounterModelList;
  const MyTile({Key? key, required this.index, this.allCounterModelList}) : super(key: key);

  @override
  State<MyTile> createState() => _MyTileState();
}

class _MyTileState extends State<MyTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25),
      child: Container(
        color: const Color(0xFFF7F5F2),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Text(
                    widget.allCounterModelList![widget.index].name.toString(),
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  " (" + countrylistener.allCountriesLists[widget.index].currency.toString() + ")",
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  countrylistener.allCountriesLists[widget.index].native.toString(),
                  style: const TextStyle(fontSize: 17),
                ),
              ],
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    countrylistener.showLangIndex.value = widget.index;
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
            Obx(() => countrylistener.showLangIndex.value == widget.index
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: countrylistener.allCountriesLists[widget.index].languages!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index2) => Row(
                        children: [
                          Text(
                            "${index2 + 1}.",
                            style: const TextStyle(fontSize: 17, color: Colors.black54),
                          ),
                          Text(
                            countrylistener.allCountriesLists[widget.index].languages![index2].name.toString(),
                            style: const TextStyle(fontSize: 17, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  )
                : Row())
          ],
        ),
      ),
    );
  }
}
