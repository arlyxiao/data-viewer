import 'package:flutter/material.dart';

import '../widgets/main_layout.dart';
import '../widgets/connection_form.dart';

class Connection extends StatelessWidget {
  const Connection({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainLayout(
        child: Column(
      children: [
        Center(
          child: SizedBox(width: 350, child: ConnectionForm()),
        ),
      ],
    ));
  }
}
