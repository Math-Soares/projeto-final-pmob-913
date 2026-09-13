import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:albedo/widget/build_container_weekprevious.dart';

class WeekpreviousPage extends StatefulWidget {
  const WeekpreviousPage({super.key});

  @override
  State<WeekpreviousPage> createState() => _WeekpreviousPageState();
}

class _WeekpreviousPageState extends State<WeekpreviousPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          Text(
            'Previsão da semana',
            style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w700),
          ),

          SizedBox(height: 10),

          BuildContainerWeekprevious(text: 'Dom.: Máx. 30°/Min. 18°'),
          BuildContainerWeekprevious(text: 'Seg.: Máx. 30°/Min. 18°'),
          BuildContainerWeekprevious(text: 'Ter.: Máx. 30°/Min. 18°'),
          BuildContainerWeekprevious(text: 'Qua.: Máx. 30°/Min. 18°'),
          BuildContainerWeekprevious(text: 'Qui.: Máx. 30°/Min. 18°'),
          BuildContainerWeekprevious(text: 'Sex.: Máx. 30°/Min. 18°'),
          BuildContainerWeekprevious(text: 'Sáb.: Máx. 30°/Min. 18°'),
        ],
      ),
    );
  }
}
