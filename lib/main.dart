import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './common/theme.dart';
import 'route.dart';
import 'models/connection_model.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (BuildContext context) => ConnectionModel())],
      child: MaterialApp.router(
        title: 'Database Viewer',
        theme: appTheme,
        routerConfig: router(),
      ),
    );
  }
}
