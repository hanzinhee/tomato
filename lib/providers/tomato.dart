import 'package:flutter/foundation.dart';
import 'package:tomato/models/to_terminal.dart';

class Tomato with ChangeNotifier {
  String _fromTerminalName = '사창리';
  int _toTerminalId;
  String _toTerminalName;

  int getToTerminalId() {
    return _toTerminalId;
  }

  String getToTerminalName() {
    return _toTerminalName;
  }

  String getFromTerminalName() {
    return _fromTerminalName;
  }

  void setTerminal(ToTerminal value) {
    _toTerminalId = value.id;
    _toTerminalName = value.name;
    notifyListeners();
  }
}
