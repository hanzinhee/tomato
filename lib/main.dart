import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomato/screens/index_page.dart';
import 'package:tomato/terminal.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TOMATO',
      home: ChangeNotifierProvider<Terminal>(
          create: (context) => Terminal(), child: IndexPage()),
    );
  }
}
