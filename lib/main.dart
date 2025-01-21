import 'package:flutter/material.dart';

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
      // Set LoginPage as the initial screen
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Variables to hold the input values
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var imageSource = "images/question-mark.jpg";

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {
                setState(() {
                  // Check the password and update the image
                  if (passwordController.text == "QWERTY123") {
                    imageSource = "images/light-bulb.jpg";
                  } else {
                    imageSource = "images/stop-sign.jpg";
                  }
                });
              },
              child: const Text('Login'),
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
