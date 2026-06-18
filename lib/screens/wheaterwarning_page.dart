import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:primeiroaplicativo/db/warning_dao.dart';
import 'package:primeiroaplicativo/domain/warning.dart';

class StormWarningPage extends StatefulWidget {
  const StormWarningPage({super.key});

  @override
  State<StormWarningPage> createState() => _StormWarningPageState();
}

class _StormWarningPageState extends State<StormWarningPage> {
  List<Warning> listWarnings = [];

  @override
  void initState() {
    super.initState();
    // É necessário pois o initState não permite parar a tela (uso do await)
    loadData();
  }

  // Carregar os dados do Banco de Dados
  Future<void> loadData() async {
    listWarnings = await WarningDao().listWarnings();
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text(
              'Alertas Climáticos',
              style: GoogleFonts.inter(
                fontSize: 35,
                fontWeight: FontWeight.w700,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: listWarnings.length,
              itemBuilder: (context, i) {
                return _buildContainer(warning: listWarnings[i]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContainer({required Warning warning}) {
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
