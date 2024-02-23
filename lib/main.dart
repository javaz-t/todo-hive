import 'package:blood_donation/hive_data/todo_hive.dart';
import 'package:blood_donation/pages/splash_screen.dart';
import'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'box_todo.dart';
import 'pages/home.dart';





main()  async {

  await Hive.initFlutter();
  Hive.registerAdapter(TodoHiveAdapter());
  boxTodo = await Hive.openBox<TodoHive>('TodoHiveBox');

  runApp(const MyApp());


}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

