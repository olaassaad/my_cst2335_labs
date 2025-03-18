import 'package:flutter/material.dart';

import 'database.dart';
import 'dao/toDoItemDao.dart';
import 'entity/toDoItem.dart';

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
  late int quantity = 1;

  late ToDoDao todoDao;
  late List<ToDoItem> items = [];

  @override //same as in java
  void initState() {
    super.initState(); //call the parent initState()
    itemInputController = TextEditingController();
    quantityInputController = TextEditingController();

    $FloorToDoDatabase.databaseBuilder('todo_database.db').build().then((db) {
      todoDao = db.toDoDao;
      todoDao.getAllToDos().then((value) {
        setState(() {
          items = value;
        });
      });
    });
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
          mainAxisAlignment: MainAxisAlignment.start,
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
      Flexible(
          child: TextField(
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
    var todo = ToDoItem(ToDoItem.ID++, itemInputController.text, quantity);

    todoDao.insertToDo(todo).then((value) {
      setState(() {
        items.add(todo);
        itemInputController.text = "";
        quantity = 1;
      });
    });
  }

  void deleteItem(int rowNum) {
    todoDao.deleteToDo(items[rowNum]).then((value) {
      setState(() {
        items.removeAt(rowNum);
      });
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
    if (items.isEmpty) {
      return const Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Text("There are no items in the list"));
    }
    return Expanded(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (inContext, rowNum) {
          var todo = items[rowNum];
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.symmetric(
                  vertical: 6), // Add spacing between rows
              decoration: BoxDecoration(
                color: Colors.grey.shade100, // Light background
                borderRadius: BorderRadius.circular(12), // Rounded corners
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: GestureDetector(
                  onLongPress: () {
                    promptRemove(inContext, rowNum);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Space between text elements
                    children: [
                      Text(
                        "Item ${rowNum + 1}: ",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                          child: Center(
                        child: Text(
                          todo.text,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 18),
                        ),
                      )),
                      Text(
                        " x ${todo.quantity}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
            ),
          );
        },
      ),
    );
  }

  void promptRemove(BuildContext inContext, int rowNum) {
    var todo = items[rowNum];

    showDialog(
        context: inContext,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Remove Item?'),
              content: Text("Do you want to remove: '${todo.text}'"),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    deleteItem(rowNum);
                    Navigator.pop(context);
                  },
                  child: const Text('Yes'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('No'),
                ),
              ],
            ));
  }
}
