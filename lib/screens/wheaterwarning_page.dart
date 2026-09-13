import 'package:albedo/api/warning_api.dart';
import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:albedo/domain/warning.dart';
import 'package:albedo/widget/build_container_warning.dart';

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
    listWarnings = WarningApi().listWarnings();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          Text(
            'Alertas Climáticos',
            style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w700),
          ),

          SizedBox(height: 10),

          FutureBuilder(
            future: listWarnings,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                );
              }

              if (snapshot.hasError) {
                return Text('Erro ao carregar alertas');
              }

              if (snapshot.hasData) {
                List<Warning> list = snapshot.requireData;
                return buildListView(list);
              }

              return CircularProgressIndicator(color: Colors.blue);
            },
          ),
        ],
      ),
    );
  }

  ListView buildListView(List<Warning> listWarnings) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: listWarnings.length,
      itemBuilder: (context, i) {
        return BuildContainerWarning(warning: listWarnings[i]);
      },
    );
  }
}
