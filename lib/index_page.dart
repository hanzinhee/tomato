import 'package:flutter/material.dart';
import 'package:cupertino_stackview/cupertino_stackview.dart';
import 'package:provider/provider.dart';
import 'package:tomato/terminal.dart';

class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    cupertinoStackViewController.initialise(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    Widget destination() {
      List<Widget> destinationList = [];

      for (var i = 1; i < 15; i++) {
        destinationList.addAll([
          Card(
            key: Key('$i'),
            child: ListTile(
              leading: Icon(Icons.location_on, size: 50),
              title: Text('춘천$i'),
              subtitle: Text('사창리 >>> 춘천'),
              trailing: Icon(Icons.more_vert),
              // onLongPress: () {},
              // onTap: () {
              //   Provider.of<Terminal>(context, listen: false).setTerminal('춘천');
              //   cupertinoStackViewController.navigate(
              //       'stack_schedule', context, null);
              // },
            ),
          ),
        ]);
      }

      return Container(
        margin: EdgeInsets.only(top: 60),
        child: ReorderableListView(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
          onReorder: (int oldIndex, int newIndex) {},
          children: destinationList,
        ),
      );
    }

    return CupertinoStackView(
      true,
      'index',
      Scaffold(
        backgroundColor: Color(0xFFF24141),
        body: destination(),
      ),
      Colors.black,
    );
  }
}
