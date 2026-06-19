import 'package:flutter/material.dart';

class BuildCardConfig extends StatelessWidget {
  final Widget child;

  const BuildCardConfig({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
     return Card(margin: EdgeInsets.only(bottom: 10), child: child);
  }
}
