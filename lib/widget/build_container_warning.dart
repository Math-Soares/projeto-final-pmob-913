import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:primeiroaplicativo/domain/warning.dart';

class BuildContainerWarning extends StatelessWidget {
  final Warning warning;
  const BuildContainerWarning({super.key, required this.warning});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    Color color = switch (warning.level) {
      1 => Colors.green,
      2 => Colors.yellow,
      3 => Colors.red,
      _ => Colors.transparent,
    };

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: color,
      ),
      margin: EdgeInsets.all(12),
      padding: EdgeInsets.only(left: 7),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: colorScheme.surfaceContainerHigh,
        ),
        padding: EdgeInsets.all(14),
        child: Column(
          children: [
            Text(
              warning.title,
              style: GoogleFonts.inter(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(warning.description, style: GoogleFonts.inter(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
