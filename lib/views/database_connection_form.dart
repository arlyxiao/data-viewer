import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../common/constant.dart';
import '../models/form.dart';
import './database_menu.dart';

class DatabaseConnectionForm extends StatefulWidget {
  const DatabaseConnectionForm({super.key});

  @override
  State<DatabaseConnectionForm> createState() => _FormState();
}

class _FormState extends State<DatabaseConnectionForm> {
  var _host = DatabaseConstant.host;
  var _port = DatabaseConstant.port;
  var _username = DatabaseConstant.username;
  var _password = DatabaseConstant.password;
  var _db = DatabaseConstant.name;

  Future<void> _connect() async {
    final database = Provider.of<FormModel>(context, listen: false).database;
    await Provider.of<FormModel>(context, listen: false).insert(
        database: database,
        host: _host,
        port: _port,
        username: _username,
        password: _password,
        db: _db);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DatabaseDropdownMenu(),
        TextFormField(
          initialValue: DatabaseConstant.host,
          decoration:
              const InputDecoration(border: InputBorder.none, hintText: 'host'),
          onChanged: (text) {
            setState(() {
              _host = text;
            });
          },
        ),
        TextFormField(
          initialValue: '${DatabaseConstant.port}',
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(5),
          ],
          decoration:
              const InputDecoration(border: InputBorder.none, hintText: 'Port'),
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
        TextFormField(
          initialValue: DatabaseConstant.username,
          decoration: const InputDecoration(
              border: InputBorder.none, hintText: 'Username'),
          onChanged: (text) {
            setState(() {
              _username = text;
            });
          },
        ),
        TextFormField(
          initialValue: DatabaseConstant.password,
          decoration: const InputDecoration(
              border: InputBorder.none, hintText: 'Password'),
          onChanged: (text) {
            setState(() {
              _password = text;
            });
          },
        ),
        TextFormField(
          initialValue: DatabaseConstant.name,
          decoration: const InputDecoration(
              border: InputBorder.none, hintText: 'Database Name'),
          onChanged: (text) {
            setState(() {
              _db = text;
            });
          },
        ),
        TextButton(onPressed: _connect, child: const Text('Connect'))
      ],
    );
  }
}
