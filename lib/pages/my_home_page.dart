import 'package:flutter/material.dart';
import 'package:flutter_application_5/pages/show_page.dart';
import 'package:flutter_application_5/todo/todo_item.dart';
import 'package:flutter_application_5/todo/todo_service.dart';

class MyHomePage extends StatefulWidget {
   MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

final ToDoService _toDoService = ToDoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      backgroundColor: Colors.grey.shade400,
      body: FutureBuilder(
        future: _toDoService.getAllTodos(),
        builder:(BuildContext context,AsyncSnapshot<List<ToDoItem>> snapshot){
          if(snapshot.connectionState==ConnectionState.done){
            return ShowPage();
          }
          else{
            return CircularProgressIndicator();
          }

        } ,
      ),

      
      

    );
  }
}