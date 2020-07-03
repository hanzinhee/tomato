import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomato/terminal.dart';
import 'package:tomato/screens/widgets/schedule_widget.dart';

class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFFF24141),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[Positioned(bottom: 0, child: ScheduleWidget())],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            Provider.of<Terminal>(context, listen: false).setTerminal('사창리'),
        label: Text('터미널선택'),
        icon: Icon(Icons.directions_bus),
        backgroundColor: Color(0xFFF27272),
      ),
    );
  }
}
