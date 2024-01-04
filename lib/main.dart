import 'package:flutter/material.dart';
import 'router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: RouterPage(
          initialRoute: '/',
          initialArguments: {'username': '', 'password': ''}),
    );
  }
}
