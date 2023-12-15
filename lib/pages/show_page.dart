import 'package:flutter/material.dart';
import 'package:flutter_application_5/todo/todo_item.dart';
import 'package:flutter_application_5/todo/todo_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ShowPage extends StatefulWidget {
  const ShowPage({super.key});

  @override
  State<ShowPage> createState() => _ShowPageState();
}

class _ShowPageState extends State<ShowPage> {

   final themeBox = Hive.box('themeBox');

  final ToDoService _toDoService = ToDoService();

  final TextEditingController tfTitle = TextEditingController();
  final TextEditingController tfSubtitle = TextEditingController();



  showMessage(String title) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("$title has been deleted"),
    ));
  }

  myShowDialog(int index, ToDoItem? item) {
  final TextEditingController editTfTitle = TextEditingController();
  final TextEditingController editTfSubtitle = TextEditingController();

  editTfTitle.text = item?.title ?? '';
  editTfSubtitle.text = item?.subtitle ?? '';
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Edit Todo"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: editTfTitle,
                ),
                TextField(
                  controller: editTfSubtitle,
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  var todo = ToDoItem(editTfTitle.text, editTfSubtitle.text, false);

                  await _toDoService.updateTodo(index, todo);

                  Navigator.pop(context);
                },
                child: Text(
                  "Update",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = themeBox.get('darkMode') ?? false;
    return Scaffold(
      appBar: AppBar(
        leading: Switch(
                      value: isDarkMode,
                      onChanged: (value) {
                        setState(() {
                          themeBox.put('darkMode', value);
                        });
                      },
                    ),
        
        title: Text(
          "TODO",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
       
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<ToDoItem>('todoBox').listenable(),
        builder: (context, box, Widget) {
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              var todo = box.getAt(index);
              return ListTile(
                title: Text(
                  todo!.title,
                  style: todo.isCompleted
                      ? TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough)
                      : TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(todo.subtitle,
                    style: todo.isCompleted
                        ? TextStyle(
                            fontSize: 18,
                            decoration: TextDecoration.lineThrough)
                        : TextStyle(fontSize: 18)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          _toDoService.deleteTodo(index);

                          showMessage(todo.title);
                        },
                        icon: Icon(
                          Icons.delete,
                          
                        )),
                    IconButton(
                        onPressed: () {
                          myShowDialog(index, todo);
                        },
                        icon: Icon(Icons.edit)),
                  ],
                ),
                leading: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (value) {
                    _toDoService.updateIsCompleted(index, todo);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
      backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () async {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Add Todo"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: tfTitle,
                        decoration: InputDecoration(
                          hintText: "Title",
                        ),
                      ),
                      TextField(
                        controller: tfSubtitle,
                        decoration: InputDecoration(
                          hintText: "Subtitle",
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () async {
                        if (tfTitle.text.isEmpty && tfSubtitle.text.isEmpty) {
                          Navigator.pop(context);
                        } else {
                          var todo =
                              ToDoItem(tfTitle.text, tfSubtitle.text, false);

                          await _toDoService.addItem(todo);

                          

                          tfTitle.text = '';
                          tfSubtitle.text = '';

                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        "Add",
                       
                      ),
                      
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}
