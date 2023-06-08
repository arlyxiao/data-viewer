import 'package:flutter/foundation.dart';
import 'package:mysql1/mysql1.dart';

class FormModel extends ChangeNotifier {
  final dbTypes = ['mysql', 'postgres'];
  var dbList = {
    'mysql': [],
    'postgres': [],
  };
  var person = {'counter': 0};

  int get counter => person['counter']!;

  Future<void> insert({required String type, required String host, required String username, required String password}) async {
    /* if (!dbTypes.contains(type)) {
      return;
    } */

    try {
      var settings = ConnectionSettings(host: 'localhost', port: 3306, user: 'root', db: 'test');
      var conn = await MySqlConnection.connect(settings);
      var results = await conn.query('SELECT * FROM `users`');

      if (kDebugMode) {
        // print(results);
      }

      for (var row in results.toList()) {
        if (kDebugMode) {
          // print(row.fields.keys);
        }
        var keys = row.fields.keys.toList();
        // ignore: avoid_print
        print('${keys[0]}, ${row[0]}');
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print('something is wrong: $e');
      }
    }

    // dbList[type]!.add({'host': host, 'username': username, 'password': password});

    notifyListeners();
  }

  void increase() {
    person['counter'] = person['counter']! + 1;

    notifyListeners();
  }
}
