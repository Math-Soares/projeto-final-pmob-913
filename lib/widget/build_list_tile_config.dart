import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildListTileConfig extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const BuildListTileConfig({super.key,  required this.title,
    required this.subtitle, required this.value,  required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      title: Text(
        title,
        style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: Colors.white,
        activeTrackColor: Colors.green[300],

        ///activeThumbColor: colorScheme.onPrimary,
        ///activeTrackColor: colorScheme.primary,
      ),
    );
  }
}
