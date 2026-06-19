import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildSegmentConfig extends StatelessWidget {
  final bool isDark;
  final String leftLabel;
  final String rightLabel;
  final String selected;
  final ValueChanged<String> onChanged;

  const BuildSegmentConfig({super.key, required this.isDark, required this.leftLabel,
    required this.rightLabel, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _segmentButton(
                isDark: isDark,
                label: leftLabel,
                isSelected: selected == leftLabel,
                onTap: () => onChanged(leftLabel),
              ),
              const SizedBox(width: 6),
              _segmentButton(
                isDark: isDark,
                label: rightLabel,
                isSelected: selected == rightLabel,
                onTap: () => onChanged(rightLabel),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _segmentButton({
    required bool isDark,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? Colors.blue : Colors.transparent,
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
