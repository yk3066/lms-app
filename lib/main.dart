import 'package:flutter/material.dart';
import 'package:geoguru/authScreen.dart';
import 'package:geoguru/auth_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AuthScreens(),
    );
  }
}
