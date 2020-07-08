import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_stackview/cupertino_stackview.dart';
import 'package:provider/provider.dart';
import 'package:tomato/models/to_terminal.dart';
import 'package:tomato/providers/tomato.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

// 서버로부터 데이터를 수신하여 그 결과를 List<ToTerminal> 형태의 Future 객체로 반환하는 async 함수
Future<List<ToTerminal>> fetchToTerminals(http.Client client) async {
  // 해당 URL로 데이터를 요청하고 수신함
  final response =
      await client.get('http://tomato-console.ga/api/to-terminals');

  // parsePhotos 함수를 백그라운도 격리 처리
  return compute(parseToTermianls, response.body);
}

// 수신한 데이터를 파싱하여 List<Photo> 형태로 반환
List<ToTerminal> parseToTermianls(String responseBody) {
  // 수신 데이터를 JSON 포맷(JSON Array)으로 디코딩
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  // JSON Array를 List<Photo>로 변환하여 반환
  return parsed.map<ToTerminal>((json) => ToTerminal.fromJson(json)).toList();
}

class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    cupertinoStackViewController.initialise(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);

    return CupertinoStackView(
      true,
      'index',
      Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            brightness: Brightness.light,
            elevation: 0,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.vertical(
            //     bottom: Radius.circular(30),
            //   ),
            // ),
            // toolbarOpacity: 0.1,
            backgroundColor: Color(0xFFFF6347),
            centerTitle: true,
            title: Text(
              "사창리 버스터미널 시간표",
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 28),
            ),
          ),
        ),
        backgroundColor: Color(0xFFFF6347),
        body: FutureBuilder<List<ToTerminal>>(
          // future 항목에 fetchToTerminals 함수 설정. fetchToTerminals Future 객체를 결과값으로 반환
          future: fetchToTerminals(http.Client()),
          // Future 객체를 처리할 빌더
          builder: (context, snapshot) {
            // 에러가 발생하면 에러 출력
            if (snapshot.hasError) print(snapshot.error);
            // 정상적으로 데이터가 수신된 경우
            return snapshot.hasData
                ? ToTerminalsList(toTermianls: snapshot.data) // PhotosList를 출력
                : Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white70))); // 데이터 수신 전이면 인디케이터 출력
          },
        ),
      ),
      Colors.black,
    );
  }
}

class ToTerminalsList extends StatelessWidget {
  final List<ToTerminal> toTermianls;

  const ToTerminalsList({Key key, this.toTermianls}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: size.height * 0.01),
      padding:
          EdgeInsets.only(left: size.width * 0.02, right: size.width * 0.02),
      child: ReorderableListView(
        onReorder: (int oldIndex, int newIndex) {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("$oldIndex >> $newIndex")));
        },
        children: [
          for (final ToTerminal in toTermianls)
            Container(
              margin: EdgeInsets.only(bottom: size.height * 0.01),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(36))),
              key: Key('${ToTerminal.id}'),
              child: ListTile(
                leading: Icon(
                  Icons.location_on,
                  size: 36,
                  // color: Color(0xFFD92534),
                ),
                title: Text(
                  '${ToTerminal.name}',
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text('사창리 >>> ${ToTerminal.name}'),
                // trailing: Icon(Icons.more_vert),
                onTap: () {
                  Provider.of<Tomato>(context, listen: false)
                      .setTerminal(ToTerminal);
                  cupertinoStackViewController.navigate(
                      'stack_schedule', context, null);
                },
              ),
            )
        ],
      ),
    );
  }
}
