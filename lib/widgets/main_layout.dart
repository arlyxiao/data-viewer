import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  Widget child;

  MainLayout({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: 800,
            width: 800,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: child));
  }
}
