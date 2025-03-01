import 'package:api_tutorial/example_three.dart';
import 'package:api_tutorial/example_two.dart';
import 'package:api_tutorial/home_screen.dart';
import 'package:api_tutorial/product_screen.dart';
import 'package:api_tutorial/signup.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: SignUpScreen(),
    );
  }
}
