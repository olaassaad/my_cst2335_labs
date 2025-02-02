import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';

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
  late BuildContext theContext;

  late TextEditingController _controller; //late - Constructor in initState()

  var isChecked = false;

  @override //same as in java
  void initState() {
    super.initState(); //call the parent initState()
    _controller = TextEditingController(); //our late constructor

    fetchName().then((name) {
      _controller.text = name;
      if (name.isNotEmpty) {
        showSnackBar("Welcome back $name");
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
    theContext = context;

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
            ElevatedButton( onPressed: loginButtonClicked, //Lambda, or anonymous function
                child:const Text("Login"),
            ),
            ElevatedButton(
                onPressed: clearLogin,
                child: const Text('Logout')),
          ],
        ),
      ),
    );
  }

  void loginButtonClicked() {
    showAlertDialog();
  }

  void clearLogin() {
    EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
    prefs.remove("Name").then((value) {
      _controller.text = "";
    });
  }

  void showAlertDialog() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Stay logged in?'),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () {
                  saveName();
                  closeDialog();
                  showSnackBar('You are logged in!');
                },
                child: const Text('Yes'),
            ),
            ElevatedButton(
                onPressed: () {
                  closeDialog();
                  clearLogin();
                },
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

  void saveName() {
    EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
    prefs.setString("Name", _controller.value.text);
  }

  Future<String> fetchName() async {
    EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
    return prefs.getString("Name");
  }
}
