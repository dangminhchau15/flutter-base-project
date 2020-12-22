import 'package:app/resources/values/colors.dart';
import 'package:app/screens/main/main_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chợ Giá",
      home: MainScreen(),
    );
  }
}
