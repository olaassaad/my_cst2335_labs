import 'package:floor/floor.dart';
import 'package:my_cst2335_labs/entity/toDoItem.dart';

@dao
abstract class ToDoDao {
  @Query('SELECT * FROM ToDoItem')
  Future<List<ToDoItem>> getAllToDos();

  @insert
  Future<void> insertToDo(ToDoItem toDoItem);

  @delete
  Future<void> deleteToDo(ToDoItem item);
}
