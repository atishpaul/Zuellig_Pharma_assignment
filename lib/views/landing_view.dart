import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'country_list_and_search.dart';

class LandingView extends StatefulWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Welcome to Zuellig Pharma",style: TextStyle(fontSize: 15),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("By Atish Paul",style: TextStyle(fontSize: 14),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    SmartDialog.showLoading(msg: 'Getting country lists..');
                    countrylistener.getAllCountryList().then((value) {
                      SmartDialog.dismiss();
                      if(value.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CountriesList()),
                        );
                      }
                    });
                  }, child: const Text("Select Countries")),
            ],
          ),
        ],
      ),
    );
  }
}
