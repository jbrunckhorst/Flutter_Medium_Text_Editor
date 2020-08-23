import 'package:flutter/material.dart';

import 'text_editor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medium-like Text Editor',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.teal,
        fontFamily: 'Georgia',  
      ),
      debugShowCheckedModeBanner: false,
      home: TextEditor()
    );
  }
}