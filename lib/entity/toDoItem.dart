import 'package:floor/floor.dart';

@entity
class ToDoItem {
  static int ID = 0;

  @primaryKey
  final int id;
  final String text;
  final int quantity;

  ToDoItem(this.id, this.text, this.quantity) {
    if(id >= ID) {
      ID = id + 1;
    }
  }
}
