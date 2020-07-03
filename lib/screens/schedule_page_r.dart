import 'package:flutter/material.dart';
import 'package:tomato/screens/widgets/schedule_card.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    Widget label() => Container(
          margin: EdgeInsets.only(left: 10),
          padding: const EdgeInsets.all(10.0),
          child: Row(children: <Widget>[
            Icon(Icons.pin_drop),
            Text(
              "춘천행",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 28),
            ),
          ]),
        );

    Widget schedule() {
      List<Widget> scheduleList = [];

      for (var i = 1; i < 24; i++) {
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

      return ListView(
        padding: EdgeInsets.all(15),
        children: scheduleList,
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFFF2F5F8),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          TitleWidget(),
          Container(
              alignment: Alignment.bottomLeft,
              height: size.height * 0.07,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.25),
                    spreadRadius: 5,
                    blurRadius: 20,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: label()),
          Container(
              height: size.height * 0.8,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: schedule()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: Icon(Icons.directions_bus),
      ),
    );
  }
}
