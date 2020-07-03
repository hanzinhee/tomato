import 'package:flutter/foundation.dart';

class Terminal with ChangeNotifier {
  String _terminal = '';

  String getTerminal() {
    return _terminal;
  }

  void setTerminal(value) {
    _terminal = value;
    notifyListeners();
  }
}
