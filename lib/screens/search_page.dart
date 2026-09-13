import 'package:albedo/api/cities_api.dart';
import 'package:albedo/api/city_api.dart';
import 'package:albedo/domain/city_summary.dart';
import 'package:albedo/screens/citydetails_page.dart';
import 'package:albedo/widget/section_title_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:albedo/widget/city_card_search.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _query = '';
  late Future<List<CitySummary>> listCities;

  @override
  void initState() {
    super.initState();
    listCities = CitiesApi().listCities();
  }

  void _reloadCities() {
    setState(() {
      listCities = CitiesApi().listCities();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Buscar Cidade',
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 5),
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
                      onChanged: (v) {
                        setState(() {
                          _query = v.trim().toLowerCase();
                        });
                      },
                      textInputAction: TextInputAction.search,
                      onSubmitted: (v) => _searchGlobal(v.trim()),
                    ),
                  ),
                ],
              ),
            ),

            SectionTitleSearch(
              text: _query.isEmpty ? 'Populares' : 'Resultados',
            ),

            Expanded(
              child: FutureBuilder(
                future: listCities,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.blue),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Erro ao carregar cidades'),
                          SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: _reloadCities,
                            child: Text('Tentar novamente'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (snapshot.hasData) {
                    List<CitySummary> list = snapshot.requireData;

                    if (_query.isNotEmpty) {
                      list =
                          list
                              .where(
                                (c) => c.name.toLowerCase().contains(_query),
                              )
                              .toList();
                    }

                    if (list.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Nenhuma cidade para "$_query"'),
                            Text(
                              'Verifique a grafia ou pressione Enter para buscar',
                            ),
                          ],
                        ),
                      );
                    }

                    return buildListView(list);
                  }

                  return Center(
                    child: CircularProgressIndicator(color: Colors.blue),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _searchGlobal(String name) async {
    if (name.isEmpty) return;

    final city = await CityApi().fetchWeatherData(name);

    if (!mounted) return;

    if (city == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Cidade "$name" não encontrada')));
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CityDetailsPage(city: city)),
    );
  }

  ListView buildListView(List<CitySummary> listCities) {
    return ListView.builder(
      itemCount: listCities.length,
      itemBuilder: (context, i) {
        return CityCardSearch(
          name: listCities[i].name,
          state: listCities[i].state,
        );
      },
    );
  }
}
