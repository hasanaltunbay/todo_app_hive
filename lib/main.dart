import 'package:flutter/material.dart';
import 'package:flutter_application_5/pages/my_home_page.dart';
import 'package:flutter_application_5/theme/dart_theme.dart';
import 'package:flutter_application_5/theme/light_theme.dart';
import 'package:flutter_application_5/todo/todo_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {

  await Hive.initFlutter();
  Hive.registerAdapter(ToDoItemAdapter());

  await Hive.openBox('themeBox');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late Box themeBox;

@override
  void initState() {
    super.initState();
    themeBox = Hive.box('themeBox');
    themeBox.listenable().addListener(() {setState(() {
      
    }); });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = themeBox.get('darkMode') ?? false;
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? darkTheme : lightTheme,
      home:  MyHomePage(),
      
    );
  }
}

