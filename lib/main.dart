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


  late TextEditingController _controller; //late - Constructor in initState()

  var isChecked = false;

  @override //same as in java
  void initState() {
    super.initState(); //call the parent initState()
    _controller = TextEditingController(); //our late constructor
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
        title: Text("Week 4"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton( onPressed: buttonClicked, //Lambda, or anonymous function
                child:Text("Click Here"),
            )
          ],
        ),
      ),
    );
  }

  //this runs when you click the button
  void buttonClicked(){
    showAlertDialog();
  }

  void showAlertDialog() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Button Alert'),
          content: const Text('Show a SnackBar?'),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () => {
                  showSnackBar('Yes was pressed'),
                  closeDialog(),
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
}
