import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  late TextEditingController _controller; //late - Constructor in initState()

  var isChecked = false;

  @override //same as in java
  void initState() {
    super.initState(); //call the parent initState()
    _controller = TextEditingController(); //our late constructor

    fetchName().then((name) {
      if (name != null) {
        _controller.text = name;
      }
    });
  }


  @override
  void dispose()
  {
    super.dispose();
    _controller.dispose();    // clean up memory
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Week 4"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your name',
                labelText: 'Name',
              ),
            ),
            ElevatedButton( onPressed: buttonClicked, //Lambda, or anonymous function
                child:const Text("Click Here"),
            )
          ],
        ),
      ),
    );
  }

  //this runs when you click the button
  void buttonClicked() {
    showAlertDialog();
  }

  void showAlertDialog() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Button Alert'),
          content: const Text('Save Login?'),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () async {
                  await saveName();
                  closeDialog();
                },
                child: const Text('Yes'),
            ),
            ElevatedButton(
                onPressed: () => closeDialog(),
                child: const Text('No'),
            ),
          ],
        ),
    );
  }

  void closeDialog() {
    Navigator.pop(context);
  }

  void showSnackBar(String message) {
    var snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'Hide',
        onPressed: () { },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> saveName() async {
    return SharedPreferences.getInstance().then((prefs) {
      prefs.setString("Name", _controller.value.text);
    });
  }

  Future<String?> fetchName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("Name");
  }
}
