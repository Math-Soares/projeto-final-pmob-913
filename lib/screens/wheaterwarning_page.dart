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
  late Future<List<Warning>> listWarnings;

  @override
  void initState() {
    super.initState();
    listWarnings = WarningDao().listWarnings();
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

            FutureBuilder(
              future: listWarnings,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Warning> list = snapshot.requireData;
                  return buildListView(list);
                }

                return CircularProgressIndicator(color: Colors.blue);
              },
            ),
          ],
        ),
      ),
    );
  }

  ListView buildListView(listWarnings) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: listWarnings.length,
      itemBuilder: (context, i) {
        return BuildContainerWarning(warning: listWarnings[i]);
      },
    );
  }
}
