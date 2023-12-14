

import 'package:flutter_application_5/todo/todo_item.dart';
import 'package:hive/hive.dart';

class ToDoService{

final String _boxName = "todoBox";

Future<Box<ToDoItem>> get _box async => await Hive.openBox<ToDoItem>(_boxName);

Future<void> addItem (ToDoItem toDoItem) async {

var box = await _box;

await box.add(toDoItem);

}

Future<List<ToDoItem>> getAllTodos() async {
var box = await _box;

return box.values.toList();
}

Future<void> deleteTodo(int index) async {
  var box = await _box;

  box.deleteAt(index);

}

Future<void> updateIsCompleted(int index,ToDoItem toDoItem) async {
  var box = await _box;

  toDoItem.isCompleted = !toDoItem.isCompleted;

  await box.putAt(index, toDoItem);

}

Future<void> updateTodo(int index,ToDoItem toDoItem) async{
  var box = await _box;

  box.putAt(index, toDoItem);
}



}