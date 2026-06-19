import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:primeiroaplicativo/db/warning_dao.dart';
import 'package:primeiroaplicativo/domain/warning.dart';
import 'package:primeiroaplicativo/widget/build_container_warning.dart';

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
                return BuildContainerWarning(warning: listWarnings[i]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
