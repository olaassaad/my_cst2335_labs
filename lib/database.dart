import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/toDoItemDao.dart';
import 'entity/toDoItem.dart';

// Generate using `flutter packages pub run build_runner build`
part 'database.g.dart'; // The generated code will be there

@Database(version: 1, entities: [ToDoItem])
abstract class ToDoDatabase extends FloorDatabase {
  ToDoDao get toDoDao;
}
