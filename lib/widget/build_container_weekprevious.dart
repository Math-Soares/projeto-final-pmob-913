import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildContainerWeekprevious extends StatelessWidget {
  final String text;

  const BuildContainerWeekprevious({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: colorScheme.surfaceContainerHigh,
      ),
      margin: EdgeInsets.all(12),
      padding: EdgeInsets.all(14),
      child: Text(text, style: GoogleFonts.inter(fontSize: 25)),
    );
  }
}
