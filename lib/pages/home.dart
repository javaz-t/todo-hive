import 'package:blood_donation/box_todo.dart';
import 'package:blood_donation/hive_data/todo_hive.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _update(int index) {
      TodoHive todoHive = boxTodo.getAt(index);
      titleController.text = todoHive.name;
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Update task',
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  setState(() {

                    todoHive.name = titleController.text;
                    boxTodo.putAt(index, todoHive);
                    titleController.clear();
                  });
                  Navigator.pop(context);
                },
                child: Text('Update'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
            ],
          );
        },
      );
    }



    ///adding new data
    _add() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'add task',
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    if(titleController.text.length>0){
                      setState(() {
                        boxTodo.put(
                            'key${titleController.text}',
                            TodoHive(
                              name: titleController.text,
                            ));
                      });
                      titleController.clear();
                    }
                Navigator.pop(context);
},
                  child: Text('SAVE'),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'))
              ],
            );
          });
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
          onPressed: () {

            _add();
          },
          child: Text('Add '),
        backgroundColor: Colors.blue, // Match the app bar color
        foregroundColor: Colors.white, // White icon for contrast
        elevation:  6.0, // Add shadow for a more pronounced appearance
        splashColor: Colors.blueAccent, ),
      appBar:  AppBar(
      backgroundColor: Colors.blue, // A stylish blue background
      elevation:  0, // Remove shadow for a flat look
      title: Text(
        'Task Management',
        style: TextStyle(
          fontSize:  24, // Large font size for readability
          fontWeight: FontWeight.bold, // Bold font for emphasis
          color: Colors.white, // White text for contrast
        ),
      ),
    ),
      body: ListView.builder(
          itemCount: boxTodo.length,
          itemBuilder: (context, index) {
            TodoHive todoHive = boxTodo.getAt(index);
            return Card(
              elevation:  5.0, // Adjust the elevation to make the card stand out more

              margin: EdgeInsets.symmetric(horizontal:  10.0, vertical:  5.0), // Add some margin around the card
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    todoHive.name,
                    style: TextStyle(
                      fontSize:  18.0, // Increase the font size
                      fontWeight: FontWeight.bold, // Make the text bold
                    ),
                  ),
                ),
                leading: IconButton(
                  icon: Icon(
                    Icons.edit_note_outlined,
                    color: Colors.blue, // Change the icon color
                  ),
                  onPressed: () {
                    _update(index);
                  },
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.remove_circle_outlined,
                    color: Colors.red, // Change the icon color
                  ),
                  onPressed: () {
                    setState(() {
                      boxTodo.deleteAt(index);
                      // To delete all: boxTodo.clear();
                    });
                  },
                ),
                tileColor: Colors.white, // Change the background color of the ListTile
              ),
            );

          }),
    );
  }
}
