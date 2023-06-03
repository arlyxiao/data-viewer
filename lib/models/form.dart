import 'package:flutter/foundation.dart';

class FormModel extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  increase() {
    _counter += 1;

    notifyListeners();
  }
}
