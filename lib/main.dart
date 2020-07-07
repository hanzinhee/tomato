import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_stackview/cupertino_stackview.dart';
import 'package:provider/provider.dart';
import 'package:tomato/providers/tomato.dart';
import 'package:tomato/index_page.dart';
import 'package:tomato/stacks/stack_schedule.dart';

GlobalKey<NavigatorState> navigatorState = GlobalKey<NavigatorState>();

void main() {
  cupertinoStackViewController = CupertinoStackViewController(
    navigatorState,
    {
      "index": (BuildContext context, dynamic parameters) {
        return IndexPage();
      },
      "stack_schedule": (BuildContext context, dynamic parameters) {
        return StackSchedule();
      },
    },
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Tomato()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TOMATO',
      home: IndexPage(),
      navigatorKey: navigatorState,
    );
  }
}
