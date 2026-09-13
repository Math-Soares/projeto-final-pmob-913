import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:albedo/domain/warning.dart';

class BuildContainerWarning extends StatelessWidget {
  final Warning warning;

  const BuildContainerWarning({super.key, required this.warning});

  @override
  Widget build(BuildContext context) {
    Color color = Colors.transparent;

    if (warning.level == 1) {
      color = Colors.green;
    } else if (warning.level == 2) {
      color = Colors.yellow;
    } else if (warning.level == 3) {
      color = Colors.red;
    }

    return Card(
      color: color,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Card(
        margin: EdgeInsets.only(left: 5),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: ListTile(
            title: Text(
              warning.title,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              warning.description,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
