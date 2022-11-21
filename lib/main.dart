import 'package:flutter/material.dart';
import 'package:todo/screens/home_screen.dart';

void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: Colors.orange[100],
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
        )
      ),
      home: const HomeScreen(),
    );
  }
}