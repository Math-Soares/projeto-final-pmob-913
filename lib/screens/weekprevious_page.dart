import 'package:albedo/api/weekly_forecast_api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:albedo/domain/weekly_forecast.dart';
import 'package:albedo/widget/build_container_weekprevious.dart';

class WeekpreviousPage extends StatefulWidget {
  const WeekpreviousPage({super.key});

  @override
  State<WeekpreviousPage> createState() => _WeekpreviousPageState();
}

class _WeekpreviousPageState extends State<WeekpreviousPage> {
  late Future<List<WeeklyForecast>> listWeeklyForecast;

  @override
  void initState() {
    super.initState();
    listWeeklyForecast = WeeklyForecastApi().listWeeklyForecast();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          Text(
            'Previsão da semana',
            style: GoogleFonts.inter(
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: 10),

          FutureBuilder(
            future: listWeeklyForecast,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Erro ao carregar previsão.');
              } else if (!snapshot.hasData) {
                return Text('A lista de previsões de dados está vázia.');
              } else {
                return buildListView(snapshot.requireData);
              }
            },
          ),
        ],
      ),
    );
  }

  ListView buildListView(List<WeeklyForecast> listWeeklyForecast) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: listWeeklyForecast.length,
      itemBuilder: (context, i) {
        return BuildContainerWeekprevious(
          text: '${listWeeklyForecast[i].day}: Máx. ${listWeeklyForecast[i].max}° / Min. ${listWeeklyForecast[i].min}°',
        );
      },
    );
  }
}