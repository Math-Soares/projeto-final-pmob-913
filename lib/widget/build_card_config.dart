import 'package:flutter/material.dart';

class BuildCardConfig extends StatelessWidget {
  final Widget child;
  final Color? color;

  const BuildCardConfig({super.key, required this.child, this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

     return Card(
         margin: EdgeInsets.only(bottom: 10),
         color: color ?? theme.cardTheme.color ?? theme.cardColor,
         child: child,
     );
  }
}
