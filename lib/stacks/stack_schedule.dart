import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cupertino_stackview/cupertino_stackview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomato/models/schedule.dart';
import 'package:tomato/providers/tomato.dart';

class StackSchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<List<Schedule>> fetchSchedule(http.Client client) async {
      final int toTerminalId = Provider.of<Tomato>(context).getToTerminalId();
      // 해당 URL로 데이터를 요청하고 수신함
      final response = await client.get(
          'http://tomato-console.ga/api/schedules/${toTerminalId.toString()}');

      // 수신 데이터를 JSON 포맷(JSON Array)으로 디코딩
      // print(response.statusCode);
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      // JSON Array를 List<Photo>로 변환하여 반환
      return parsed.map<Schedule>((json) => Schedule.fromJson(json)).toList();
    }

    cupertinoStackViewController.initialise(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);

    return CupertinoStackView(
      false,
      'stack_schedule',
      Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: <Widget>[
          Label(),
          FutureBuilder<List<Schedule>>(
            // future 항목에 fetchToTerminals 함수 설정. fetchToTerminals Future 객체를 결과값으로 반환
            future: fetchSchedule(http.Client()),
            // Future 객체를 처리할 빌더
            builder: (context, snapshot) {
              // 에러가 발생하면 에러 출력
              if (snapshot.hasError) print(snapshot.error);
              // 정상적으로 데이터가 수신된 경우
              return (snapshot.hasData && snapshot.data.length != 0)
                  ? SchedulesList(schedules: snapshot.data) // PhotosList를 출력
                  : Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.black54))); // 데이터 수신 전이면 인디케이터 출력
            },
          ),
        ]),
      ),
      Colors.black,
      isDismissible: true,
      radius: Radius.circular(30.0),
    );
  }
}

class SchedulesList extends StatelessWidget {
  final List<Schedule> schedules;

  const SchedulesList({Key key, this.schedules}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: 90 + size.width * 0.05),
      child: ListView(
        // shrinkWrap: true,
        padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
        children: [
          for (final Schedule in schedules)
            Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[300]))),
              padding: EdgeInsets.all(5.0),
              child: Row(children: <Widget>[
                Expanded(
                  child: Text(
                    '${Schedule.time}',
                    style: TextStyle(fontWeight: FontWeight.w200, fontSize: 30),
                  ),
                ),
                Icon(Icons.linear_scale)
              ]),
            )
        ],
      ),
    );
  }
}

class Label extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Container(
        height: 90,
        width: size.width * 0.5,
        decoration: BoxDecoration(
            color: Color(0xFFD92534),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Text(
            '출발 ',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w200, fontSize: 20),
          ),
          Text(
            Provider.of<Tomato>(context).getFromTerminalName(),
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 26),
          ),
        ]),
      ),
      // Icon(Icons.fast_forward),
      Expanded(
        child: Container(
          height: 90,
          alignment: Alignment.center,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '도착 ',
                  style: TextStyle(fontWeight: FontWeight.w200, fontSize: 20),
                ),
                Text(
                  Provider.of<Tomato>(context).getToTerminalName(),
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 26),
                ),
              ]),
        ),
      ),
    ]);
  }
}
