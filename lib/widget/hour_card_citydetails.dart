import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HourCardCitydetails extends StatelessWidget {
  final String hour;
  final String temp;
  final bool selected;

  const HourCardCitydetails({
    super.key,
    required this.hour,
    required this.temp,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 70,
      child: Card(
        color: selected ? Theme.of(context).colorScheme.primaryContainer : null,
        margin: EdgeInsets.only(right: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              hour,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4),
            Text(
              temp,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
