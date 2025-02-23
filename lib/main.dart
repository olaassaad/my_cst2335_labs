import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Main method
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
  late TextEditingController itemInputController;
  late TextEditingController quantityInputController;
  late List<(String, int)> items;
  late int quantity = 1;

  @override //same as in java
  void initState() {
    super.initState(); //call the parent initState()
    itemInputController = TextEditingController();
    quantityInputController = TextEditingController();
    items = [];
  }

  @override
  void dispose() {
    super.dispose();
    itemInputController.dispose();
    quantityInputController.dispose();
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
            const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
            dataEntry(),
            dataList(),
          ],
        ),
      ),
    );
  }
  
  Widget dataEntry() {
    return Row(children: [
      ElevatedButton(
          onPressed: addItem,
          child: const Text("Add"),
      ),
      const Padding(padding: EdgeInsets.symmetric(horizontal: 8.0)),
      Flexible(child: TextField(
        controller: itemInputController,
        decoration: const InputDecoration(
          hintText: "Enter item name",
          labelText: "Enter item name",
          border: OutlineInputBorder(),
        ),
      )),
      const Padding(padding: EdgeInsets.symmetric(horizontal: 8.0)),
      quantityEntry(),
    ]);
  }

  void addItem() {
    setState(() {
      items.add((itemInputController.text, quantity));
      itemInputController.text = "";
      quantity = 1;
    });
  }

  Widget quantityEntry() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: decrement,
          icon: const Icon(Icons.remove),
        ),
        SizedBox(
          width: 50, // Fixed width for text field
          child: TextField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: TextEditingController(text: quantity.toString()),
            onSubmitted: (value) {
              setState(() {
                quantity = int.tryParse(value) ?? 1;
                if (quantity < 1) quantity = 1; // Prevent invalid values
              });
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(vertical: 8),
            ),
          ),
        ),
        IconButton(
          onPressed: increment,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }

  void decrement() {
    setState(() {
      quantity--;
    });
  }

  void increment() {
    setState(() {
      quantity++;
    });
  }

  Widget dataList() {
    return Expanded(child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (inContext, rowNum) {
          var (item, count) = items[rowNum];
          return Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(children: [
                  Text("${rowNum + 1}: "),
                  Expanded(child: Text(item)),
                  Text(" x $count"),
                ])
            )
          );
        },
    ));
  }
}
