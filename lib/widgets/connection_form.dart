import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../common/constant.dart';
import '../models/connection_model.dart';
import 'database_menu.dart';

class ConnectionForm extends StatefulWidget {
  const ConnectionForm({super.key});

  @override
  State<ConnectionForm> createState() => _FormState();
}

class _FormState extends State<ConnectionForm> {
  var _host = DatabaseConstant.host;
  var _port = DatabaseConstant.port;
  var _username = DatabaseConstant.username;
  var _password = DatabaseConstant.password;
  var _name = DatabaseConstant.name;

  @override
  Widget build(BuildContext context) {
    void connect() {
      final database = context.read<ConnectionModel>().database;
      Provider.of<ConnectionModel>(context, listen: false).insert(
          database: database,
          host: _host,
          port: _port,
          username: _username,
          password: _password,
          db: _name);
    }

    return Column(
      children: <Widget>[
        const SizedBox(height: 20),
        const DatabaseDropdownMenu(),
        const SizedBox(height: 10),
        TextFormField(
          initialValue: DatabaseConstant.host,
          decoration: const InputDecoration(labelText: 'host'),
          onChanged: (text) {
            setState(() {
              _host = text;
            });
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          initialValue: '${DatabaseConstant.port}',
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(5),
          ],
          decoration: const InputDecoration(labelText: 'Port'),
          onChanged: (text) {
            setState(() {
              try {
                _port = int.parse(text);
              } on Exception catch (e) {
                // ignore: avoid_print
                print('something is wrong $e');
              }
            });
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          initialValue: DatabaseConstant.username,
          decoration: const InputDecoration(labelText: 'Username'),
          onChanged: (text) {
            setState(() {
              _username = text;
            });
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          initialValue: DatabaseConstant.password,
          decoration: const InputDecoration(labelText: 'Password'),
          onChanged: (text) {
            setState(() {
              _password = text;
            });
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          initialValue: DatabaseConstant.name,
          decoration: const InputDecoration(labelText: 'Database Name'),
          onChanged: (text) {
            setState(() {
              _name = text;
            });
          },
        ),
        const SizedBox(height: 20),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.teal,
            disabledForegroundColor: Colors.grey,
            fixedSize: const Size.fromWidth(200),
            padding: const EdgeInsets.all(20),
            textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          onPressed: connect,
          child: const Text('Connect'),
        ),
      ],
    );
  }
}
