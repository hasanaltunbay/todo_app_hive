


import 'package:hive_flutter/hive_flutter.dart';

part 'todo_item.g.dart';

@HiveType(typeId: 1)
class ToDoItem{

  @HiveField(0)
  final String title;

  @HiveField(1)
  final String subtitle;

  @HiveField(2,defaultValue: false)
  bool isCompleted;

  ToDoItem(this.title,  this.subtitle, this.isCompleted);




}