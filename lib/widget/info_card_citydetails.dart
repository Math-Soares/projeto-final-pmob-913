import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoCardCitydetails extends StatelessWidget {
  final String label;
  final String value;

  const InfoCardCitydetails({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4),
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
