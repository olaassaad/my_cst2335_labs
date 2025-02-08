import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'DataRepository.dart';

class OtherPage extends StatefulWidget {
  const OtherPage({super.key});

  @override
  State<OtherPage> createState() => OtherPageState();
}

class OtherPageState extends State<OtherPage> {
  @override
  Widget build(BuildContext context) {
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
                    onPressed: () => launchUrl(Uri.parse("https://www.google.com")),
                    child: const Text("Open Google"),
                ),
              ],
            )
        )
    ); //Use a Scaffold to layout a page with an AppBar and main body region
  }
}