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
  List<City> listCitys = [];

  @override
  void initState() {
    super.initState();
    // É necessário pois o initState não permite parar a tela (uso do await)
    loadData();
  }

  // Carregar os dados do Banco de Dados
  Future<void> loadData() async {
    listCitys = await CityDao().listCitys();
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
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

            ListView.builder(
              shrinkWrap: true,
              itemCount: listCitys.length,
              itemBuilder: (context, i) {
                return CityCardSearch(name: listCitys[i].name);
              },
            ),
          ],
        ),
      ),
    );
  }
}
