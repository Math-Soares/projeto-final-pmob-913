import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:primeiroaplicativo/widget/hour_card_citydetails.dart';
import 'package:primeiroaplicativo/widget/info_card_citydetails.dart';

class CityDetailsPage extends StatefulWidget {
  final String cityName;

  const CityDetailsPage({super.key, required this.cityName});

  @override
  State<CityDetailsPage> createState() => _CityDetailsPageState();
}

class _CityDetailsPageState extends State<CityDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back, size: 16),
                    SizedBox(width: 4),
                    Text('Voltar'),
                  ],
                ),
              ),
              SizedBox(height: 12),

              Text(
                widget.cityName,
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 20),

              Center(
                child: Column(
                  children: [
                    Icon(Icons.cloud, size: 60),
                    SizedBox(height: 8),
                    Text(
                      '32°C',
                      style: GoogleFonts.inter(
                        fontSize: 56,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Nublado · Max 34°  Min 23°',
                      style: GoogleFonts.inter(fontSize: 13),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              Text(
                'Por hora',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 70,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    HourCardCitydetails(
                      hour: '9h',
                      temp: '26°',
                      selected: false,
                    ),
                    HourCardCitydetails(
                      hour: '10h',
                      temp: '29°',
                      selected: false,
                    ),
                    HourCardCitydetails(
                      hour: '12h',
                      temp: '32°',
                      selected: true,
                    ),
                    HourCardCitydetails(
                      hour: '13h',
                      temp: '31°',
                      selected: false,
                    ),
                    HourCardCitydetails(
                      hour: '14h',
                      temp: '28°',
                      selected: false,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2,
                children: [
                  InfoCardCitydetails(label: 'Sensação', value: '33°C'),
                  InfoCardCitydetails(label: 'Índice UV', value: 'Alto'),
                  InfoCardCitydetails(label: 'Pressão', value: '1012hPa'),
                  InfoCardCitydetails(label: 'Visib.', value: '10 km'),
                  InfoCardCitydetails(label: 'Umidade', value: '72%'),
                  InfoCardCitydetails(label: 'Vento', value: '17.39 km/h'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
