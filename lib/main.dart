import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';

import 'DataRepository.dart';
import 'ProfilePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const LoginPage(),
        '/profilePage': (context) => const ProfilePage(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late BuildContext theContext;

  // Variables to hold the input values
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var imageSource = "images/question-mark.jpg";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserPreferences();
      DataRepository.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    theContext = context;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Login Name TextField
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: loginController,
                decoration: const InputDecoration(
                  labelText: 'Login Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Password TextField
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Login Button
            ElevatedButton(
              onPressed: showSaveLoginInfoDialog,
              child: const Text('Login'),
            ),
            const SizedBox(height: 16.0),
            // Login Button
            ElevatedButton(
              onPressed: clearUserPreferences,
              child: const Text('Logout'),
            ),
            const SizedBox(height: 16.0),
            // Image
            Image.asset(
              imageSource,
              height: 300,
              width: 300,
            ),
            const SizedBox(height: 16.0),
            // Navigate to Home Page Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyHomePage(title: 'Home Page'),
                  ),
                );
              },
              child: const Text('Go to Home Page'),
            ),
          ],
        ),
      ),
    );
  }

  void tryLogin() {
    setState(() {
      // Check the password and update the image
      if (passwordController.text == "QWERTY123") {
        imageSource = "images/light-bulb.jpg";
        DataRepository.loginName = loginController.text;
        Navigator.pushNamed(context, '/profilePage');
      } else {
        imageSource = "images/stop-sign.jpg";
        showLoginFailedSnackBar();
      }
    });
  }

  void saveUserPreferences() {
    // Save username and password to shared preferences.
    EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
    prefs.setString("Username", loginController.value.text);
    prefs.setString("Password", passwordController.value.text);
  }

  void loadUserPreferences() {
    // Load username and password.
    EncryptedSharedPreferences prefs = EncryptedSharedPreferences();

    prefs.getString("Username").then((username) {
      prefs.getString("Password").then((password) {
        setState(() {
          loginController.text = username;
          passwordController.text = password;
        });

        // If the login and password were set, we show a SnackBar
        if (username.isNotEmpty && password.isNotEmpty) {
          showLoginPopulatedSnackBar();
        }
      });
    });
  }

  void showLoginPopulatedSnackBar() {
    var snackBar = SnackBar(
      content: const Text('The login and password were loaded.'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: clearTextFields,
      ),
    );
    ScaffoldMessenger.of(theContext).showSnackBar(snackBar);
  }

  void showLoginFailedSnackBar() {
    var snackBar = const SnackBar(
      content: Text('The login and password did not match.'),
    );
    ScaffoldMessenger.of(theContext).showSnackBar(snackBar);
  }

  void clearUserPreferences() {
    // Clear username and password from shared preferences.
    EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
    prefs.remove("Username");
    prefs.remove("Password");
    clearTextFields();
  }

  void clearTextFields() {
    loginController.text = "";
    passwordController.text = "";
  }

  void showSaveLoginInfoDialog() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Save Login and Password?'),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              saveUserPreferences();
              closeDialog();
              tryLogin();
            },
            child: const Text('Yes'),
          ),
          ElevatedButton(
            onPressed: () {
              closeDialog();
              tryLogin();
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
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var isChecked = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Checkbox(
              value: isChecked,
              onChanged: (newValue) {
                setState(() {
                  isChecked = newValue!;
                });
              },
            ),
            Switch(
              value: isChecked,
              onChanged: (newValue) {
                setState(() {
                  isChecked = newValue;
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
