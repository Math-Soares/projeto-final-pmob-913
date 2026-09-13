import 'package:albedo/api/city_api.dart';
import 'package:albedo/db/shared_prefs.dart';
import 'package:albedo/domain/city.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<City?> futureCity;

  @override
  void initState() {
    super.initState();
    futureCity = loadCurrentCity();
  }

  Future<City?> loadCurrentCity() async {
    final saved = await SharedPrefs().getCurrentCity();

    if (saved.isEmpty) return null;

    return CityApi().fetchWeatherData(saved.trim());
  }

  void reload() {
    setState(() {
      futureCity = loadCurrentCity();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 50, bottom: 0),
        child: FutureBuilder(
          future: futureCity,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: Colors.blue),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  children: [
                    Text('Erro'),
                    ElevatedButton(
                      onPressed: reload,
                      child: Text('Tentar Novamente'),
                    ),
                  ],
                ),
              );
            } else if (!snapshot.hasData) {
              return Center(
                child: Text('Defina a cidade na tela de configurações'),
              );
            } else {
              return buildListView(snapshot.data!);
            }
          },
        ),
      ),
    );
  }

  Widget buildListView(City cidade) {
    return ListView(
      children: [
        Center(
          child: Text(
            '${cidade.name}, ${cidade.state}',
            style: GoogleFonts.inter(),
          ),
        ),

        SizedBox(height: 4),

        Center(
          child: Text(
            'Seg, 07 Abr',
            style: GoogleFonts.inter(color: Colors.blueGrey),
          ),
        ),

        SizedBox(height: 20),

        Icon(Icons.sunny, size: 40),

        SizedBox(height: 8),

        Center(
          child: Text(
            '${cidade.degrees}°',
            style: GoogleFonts.inter(fontSize: 60),
          ),
        ),

        SizedBox(height: 8),

        Center(child: Text(cidade.condition, style: GoogleFonts.inter())),

        SizedBox(height: 20),

        Row(
          children: [
            Expanded(
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      Text(
                        'Umidade',
                        style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text('${cidade.humidity}%', style: GoogleFonts.inter()),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(width: 10),

            Expanded(
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      Text(
                        'Vento',
                        style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text('${cidade.wind}km/h', style: GoogleFonts.inter()),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(width: 10),

            Expanded(
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      Text(
                        'Índice UV',
                        style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(uvTexto(cidade.uv), style: GoogleFonts.inter()),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 20),

        Center(
          child: Text(
            'Mais informações futuramente!',
            style: GoogleFonts.inter(fontWeight: FontWeight.bold),
          ),
        ),

        /*
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Próximos dias | Semana Atual',
            style: GoogleFonts.inter(fontSize: 11),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Divider(color: Colors.grey, thickness: 2),
        ),
        SizedBox(width: 10),

        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Terça', style: GoogleFonts.inter()),
                Icon(Icons.sunny),
                Text('29°', style: GoogleFonts.inter()),
              ],
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Quarta', style: GoogleFonts.inter()),
                Icon(Icons.cloud),
                Text('  26°', style: GoogleFonts.inter()),
              ],
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Quinta', style: GoogleFonts.inter()),
                Icon(Icons.water_drop),
                Text('  22°', style: GoogleFonts.inter()),
              ],
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Sexta', style: GoogleFonts.inter()),
                Icon(Icons.sunny),
                Text('28°', style: GoogleFonts.inter()),
              ],
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Sábado', style: GoogleFonts.inter()),
                Icon(Icons.cloud),
                Text('   25°', style: GoogleFonts.inter()),
              ],
            ),

            SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Próximos dias | Semana Posterior',
                style: GoogleFonts.inter(fontSize: 11),
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: Divider(
                color: Colors.grey,
                thickness: 2,
              ),
            ),
          ],
        ),

        SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Domingo'),
            Icon(Icons.cloud),
            Text('     24°'),
          ],
        ),

        SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Aguardando Informações...'),
          ],
        ),
        */
      ],
    );
  }

  String uvTexto(int uv) {
    if (uv >= 11) return 'Extremo';
    if (uv >= 8) return 'Muito Alto';
    if (uv >= 6) return 'Alto';
    if (uv >= 3) return 'Moderado';

    return 'Baixo';
  }
}
