import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:primeiroaplicativo/db/city_dao.dart';
import 'package:primeiroaplicativo/domain/city.dart';
import 'package:primeiroaplicativo/widget/city_card_search.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<List<City>> listCities;

  @override
  void initState() {
    super.initState();
    listCities = CityDao().listCitys();
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
                    ),
                  ),
                ],
              ),
            ),

            //SectionTitleSearch(text: 'Recentes'),
            //SectionTitleSearch(text: 'Populares'),

            // Provisório
            SizedBox(height: 15),

            // --
            FutureBuilder(
              future: listCities,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<City> list = snapshot.requireData;
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

  ListView buildListView(List<City> listCities) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: listCities.length,
      itemBuilder: (context, i) {
        return CityCardSearch(name: listCities[i].name);
      },
    );
  }
}
