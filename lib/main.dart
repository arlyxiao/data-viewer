import 'package:flutter/material.dart';

void main() => runApp(const ScaffoldExampleApp());

class ScaffoldExampleApp extends StatelessWidget {
  const ScaffoldExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Home());
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('nn')),
      body: const Column(children: [Text("aa"), MyWidget()]),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int _size = 1;

  void increase() {
    setState(() {
      _size += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$_size}'),
        IconButton(
            icon: const Icon(Icons.star),
            onPressed: increase,
          )
      ],
    );
  }
}
