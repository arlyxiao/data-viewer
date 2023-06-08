import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import './common/theme.dart';
import './models/form.dart';

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
        const SizedBox(width: 400, height: 300, child: DbConnectionForm()),
        const SizedBox(width: 400, height: 200, child: MyWidget()),
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
  var _type = '';
  var _host = '';
  var _username = '';
  var _password = '';

  Future<void> _connect() async {
    await Provider.of<FormModel>(context, listen: false).insert(type: _type, host: _host, username: _username, password: _password);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (text) {
            setState(() {
              _type = text;
            });
          },
        ),
        TextField(
          onChanged: (text) {
            setState(() {
              _host = text;
            });
          },
        ),
        TextField(
          onChanged: (text) {
            setState(() {
              _username = text;
            });
          },
        ),
        TextField(
          onChanged: (text) {
            setState(() {
              _password = text;
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
