import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionTitleSearch extends StatelessWidget {
  final String text;

  const SectionTitleSearch({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, bottom: 6, top: 6),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
