<<<<<<< Updated upstream
=======
import 'package:albedo/db/cities_dao.dart';
import 'package:albedo/api/city_api.dart';
import 'package:albedo/domain/city_summary.dart';
import 'package:albedo/screens/citydetails_page.dart';
import 'package:albedo/widget/section_title_search.dart';
>>>>>>> Stashed changes
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:primeiroaplicativo/screens/citydetails_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
<<<<<<< Updated upstream
=======
  String _query = '';
  late Future<List<CitySummary>> listCities;

  @override
  void initState() {
    super.initState();
    listCities = CityDao().listCities();
  }

  void _reloadCities() {
    setState(() {
      listCities = CityDao().listCities();
    });
  }

>>>>>>> Stashed changes
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          Text(
            'Buscar Cidade',
            style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w700),
          ),
          Card(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Icon(Icons.search, color: Colors.grey),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Digite o nome da cidade',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _sectionTitle('Recentes'),
          _buildCityCard('Maceió, AL'),
          _buildCityCard('São Paulo, SP'),
          _buildCityCard('Rio de Janeiro, RJ'),
          _sectionTitle('Populares'),
          _buildCityCard('Fortaleza, CE'),
          _buildCityCard('Brasília, DF'),
          _buildCityCard('Salvador, BA'),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, bottom: 6, top: 6),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  Widget _buildCityCard(String name) {
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(name),
        trailing: Icon(Icons.arrow_outward_rounded),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CityDetailsPage(cityName: name),
            ),
          );
        },
      ),
    );
  }
}
