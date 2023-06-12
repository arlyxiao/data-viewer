import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import './common/theme.dart';
import './models/form.dart';
import './views/database_connection_form.dart';

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
        const Center(
          child: SizedBox(
              width: 400, height: 600, child: DatabaseConnectionForm()),
        ),
        TextButton(
            onPressed: Provider.of<FormModel>(context).increase,
            child: const Text('increase'))
      ],
    ));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => FormModel())
      ],
      child: MaterialApp.router(
        title: 'Provider Demo',
        theme: appTheme,
        routerConfig: router(),
      ),
    );
  }
}
