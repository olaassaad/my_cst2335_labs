import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'DataRepository.dart';

class OtherPage extends StatefulWidget {
  const OtherPage({super.key});

  @override
  State<OtherPage> createState() => OtherPageState();
}

class OtherPageState extends State<OtherPage> {

  late BuildContext thisContext;

  @override
  Widget build(BuildContext context) {
    thisContext = context;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
          title: const Text("Other Page"),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Welcome back ${DataRepository.loginName}"),
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back),
                ),
                ElevatedButton(
                    onPressed: () => launchGoogle(),
                    child: const Text("Open Google"),
                ),
              ],
            )
        )
    ); //Use a Scaffold to layout a page with an AppBar and main body region
  }

  void launchGoogle() {
    Uri url = Uri.parse("https://www.google.com");
    canLaunchUrl(url).then((canL) {
      if (canL) {
        launchUrl(url);
      } else {
        ScaffoldMessenger.of(thisContext).showSnackBar(const SnackBar(
          content: Text("Cannot open Google"),
        ));
      }
    });
  }
}