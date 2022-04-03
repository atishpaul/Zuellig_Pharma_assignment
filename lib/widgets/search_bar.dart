import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ezcountries/views/country_list_and_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({Key? key}) : super(key: key);

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  @override
  Widget build(BuildContext context) {
    return Obx(()=>Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              color: const Color(0xFF333C83),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: countrylistener.searchedText,
                  onChanged: (v) {
                    if (v.isNotEmpty) {
                      countrylistener.hintState(true);
                    }
                  },
                  onSubmitted: (v) {
                    countrylistener.isSubmitted.value = true;
                    countrylistener.getCountrySearch(countrylistener.searchedText.text);
                  },
                  decoration: InputDecoration(
                    hintText: countrylistener.hint.value == false ? '' : 'Search for your country...',
                    hintStyle: const TextStyle(
                      fontSize: 17,
                      color: Colors.white70,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white70,
                    ),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.white60),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedTextKit(
                onTap: () {
                  countrylistener.hintState(true);
                },
                onFinished: () {
                  countrylistener.switchHintText();
                },
                animatedTexts: [
                  countrylistener.hint.value == false
                      ? RotateAnimatedText('select by country code..', textStyle: const TextStyle(color: Colors.white70, fontSize: 17))
                      : RotateAnimatedText(''),
                  countrylistener.hint.value == false
                      ? RotateAnimatedText('Search your destination...', textStyle: const TextStyle(color: Colors.white70, fontSize: 17))
                      : RotateAnimatedText(''),
                ],
                totalRepeatCount: 1,
                pause: const Duration(milliseconds: 1000),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
