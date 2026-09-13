import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildContainerWeekprevious extends StatelessWidget {
  final String text;

  const BuildContainerWeekprevious({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
