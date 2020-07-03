import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomato/terminal.dart';

class ScheduleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    Widget label() => Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () => Provider.of<Terminal>(context, listen: false)
                      .setTerminal(''),
                  child: Text(
                    Provider.of<Terminal>(context).getTerminal(),
                    style: TextStyle(fontWeight: FontWeight.w200, fontSize: 28),
                  ),
                ),
                Icon(Icons.arrow_right),
                Text(
                  "춘천",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 28),
                ),
              ]),
        );

    Widget schedule() {
      List<Widget> scheduleList = [];

      for (var i = 1; i < 45; i++) {
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

    return AnimatedContainer(
        alignment: Alignment.topCenter,
        height: (Provider.of<Terminal>(context).getTerminal() == '')
            ? 0
            : size.height * 0.95,
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14.0), topRight: Radius.circular(14.0)),
        ),
        duration: Duration(milliseconds: 400),
        curve: Curves.linearToEaseOut,
        child: Stack(
          children: <Widget>[label(), schedule()],
        ));
  }
}
