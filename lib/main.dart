import 'package:flutter/material.dart';
import 'package:flutter_provider_app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Provider App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      home: HomeScreen(),
    );
  }
}
