import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import './common/theme.dart';
import './models/form.dart';
import './views/db_types.dart';

void main() => runApp(const MyApp());

GoRouter router() {
  return GoRouter(
    initialLocation: '/form',
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, state) => const Home(),
      ),
      GoRoute(
        path: '/form',
        builder: (context, state) => const Form(),
      ),
    ],
  );
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class Form extends StatelessWidget {
  const Form({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Text('${context.watch<FormModel>().counter}'),
        const SizedBox(width: 400, height: 600, child: DbConnectionForm()),
        // const SizedBox(width: 400, height: 200, child: MyWidget()),
        TextButton(onPressed: Provider.of<FormModel>(context).increase, child: const Text('increase'))
      ],
    ));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (BuildContext context) => FormModel())],
      child: MaterialApp.router(
        title: 'Provider Demo',
        theme: appTheme,
        routerConfig: router(),
      ),
    );
  }
}

class DbConnectionForm extends StatefulWidget {
  const DbConnectionForm({super.key});

  @override
  State<DbConnectionForm> createState() => _DbConnectionFormState();
}

class _DbConnectionFormState extends State<DbConnectionForm> {
  var _host = 'localhost';
  var _port = 3306;
  var _username = 'root';
  var _password = '';
  var _db = '';

  Future<void> _connect() async {
    final database = Provider.of<FormModel>(context, listen: false).database;
    await Provider.of<FormModel>(context, listen: false)
        .insert(database: database, host: _host, port: _port, username: _username, password: _password, db: _db);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DropdownMenuExample(),
        TextFormField(
          initialValue: 'localhost',
          decoration: const InputDecoration(border: InputBorder.none, hintText: 'host'),
          onChanged: (text) {
            setState(() {
              _host = text;
            });
          },
        ),
        TextFormField(
          initialValue: '3306',
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(5),
          ],
          decoration: const InputDecoration(border: InputBorder.none, hintText: 'Port'),
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
          initialValue: 'root',
          decoration: const InputDecoration(border: InputBorder.none, hintText: 'Username'),
          onChanged: (text) {
            setState(() {
              _username = text;
            });
          },
        ),
        TextField(
          decoration: const InputDecoration(border: InputBorder.none, hintText: 'Password'),
          onChanged: (text) {
            setState(() {
              _password = text;
            });
          },
        ),
        TextField(
          decoration: const InputDecoration(border: InputBorder.none, hintText: 'Database Name'),
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

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var entries = context.watch<FormModel>().dbList['mysql'];

    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: entries!.length,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 50,
            child: Center(child: Text('Entry ${entries[index]}')),
          );
        });
  }
}
