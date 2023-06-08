import 'package:flutter/foundation.dart';

class FormModel extends ChangeNotifier {
  final dbTypes = ['mysql', 'postgres'];
  var dbList = {
    'mysql': [],
    'postgres': [],
  };
  var person = {'counter': 0};

  int get counter => person['counter']!;

  void insert({required String type, required String host, required String username, required String password}) {
    if (!dbTypes.contains(type)) {
      return;
    }
    
    dbList[type]!.add({'host': host, 'username': username, 'password': password});

    notifyListeners();
  }

  void increase() {
    person['counter'] = person['counter']! + 1;

    notifyListeners();
  }
}
