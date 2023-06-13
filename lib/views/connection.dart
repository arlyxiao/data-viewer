import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/main_layout.dart';
import '../widgets/connection_form.dart';
import '../models/connection_model.dart';

class Connection extends StatelessWidget {
  const Connection({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        child: Column(
      children: [
        Text('${context.watch<ConnectionModel>().counter}'),
        const Center(
          child: SizedBox(width: 400, height: 600, child: ConnectionForm()),
        ),
        TextButton(onPressed: Provider.of<ConnectionModel>(context).increase, child: const Text('increase'))
      ],
    ));
  }
}
