import 'package:cupertino_stackview/cupertino_stackview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomato/terminal.dart';

class StackSchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    cupertinoStackViewController.initialise(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    Widget label() => Container(
          margin: EdgeInsets.only(top: 20),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "사창리",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 28),
                ),
                Icon(Icons.arrow_right),
                Text(
                  Provider.of<Terminal>(context).getTerminal(),
                  style: TextStyle(fontWeight: FontWeight.w200, fontSize: 28),
                ),
              ]),
        );

    Widget schedule() {
      List<Widget> scheduleList = [];

      for (var i = 1; i < 12; i++) {
        scheduleList.addAll([
          Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[300]))),
            padding: EdgeInsets.all(5.0),
            child: Row(children: <Widget>[
              Expanded(
                child: Text(
                  '$i:30',
                  style: TextStyle(fontWeight: FontWeight.w200, fontSize: 30),
                ),
              ),
              Icon(Icons.linear_scale)
            ]),
          )
        ]);
      }

      return Container(
        margin: EdgeInsets.only(top: 50),
        child: ListView(
          // shrinkWrap: true,
          padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
          children: scheduleList,
        ),
      );
    }

    return CupertinoStackView(
      false,
      'stack_schedule',
      Scaffold(
        backgroundColor: Color(0xFFF2F2F7),
        body: Stack(children: <Widget>[label(), schedule()]),
      ),
      Colors.black,
      isDismissible: true,
      radius: Radius.circular(10.0),
    );
  }
}
