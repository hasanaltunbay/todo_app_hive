import 'package:flutter/material.dart';
import 'package:flutter_application_5/pages/my_home_page.dart';
import 'package:flutter_application_5/todo/todo_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {

  await Hive.initFlutter();
  Hive.registerAdapter(ToDoItemAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  MyHomePage(),
    );
  }
}

