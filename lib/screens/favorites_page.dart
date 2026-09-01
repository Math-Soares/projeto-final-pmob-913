import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:primeiroaplicativo/db/city_dao.dart';
import 'package:primeiroaplicativo/domain/city.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late Future<List<City>> listFavoritesCities;

  @override
  void initState() {
    super.initState();
    listFavoritesCities = CityDao().listFavoritesCitys();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.only(bottom: 6),
              child: Text(
                'Favoritos',
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            FutureBuilder(
              future: listFavoritesCities,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<City> list = snapshot.requireData;
                  return buildListView(list);
                }

                return CircularProgressIndicator(color: Colors.blue);
              },
            ),

            _adicionarCidadeCard(),
          ],
        ),
      ),
    );
  }

  ListView buildListView(listFavoritesCities) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: listFavoritesCities.length,
      itemBuilder: (context, i) {
        return _cidadeFavoritaCard(
          cidade:
              '${listFavoritesCities[i].name}, ${listFavoritesCities[i].state}',
          clima: listFavoritesCities[i].condition,
          temperatura: '${listFavoritesCities[i].degrees}°',
          isLocalizacaoAtual: listFavoritesCities[i].isMyLocation,
        );
      },
    );
  }

  Widget _cidadeFavoritaCard({
    required String cidade,
    required String clima,
    required String temperatura,
    bool isLocalizacaoAtual = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cidade,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(clima, style: GoogleFonts.inter()),
              if (isLocalizacaoAtual) ...[
                const SizedBox(height: 2),
                Text(
                  'Localização atual',
                  style: GoogleFonts.inter(fontSize: 12),
                ),
              ],
            ],
          ),
          Text(
            temperatura,
            style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _adicionarCidadeCard() {
    final colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton(
      onPressed: () => {},
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsetsGeometry.all(15),
        foregroundColor: colorScheme.onSurface,
      ),
      child: Text('+ Adicionar cidade', style: GoogleFonts.inter()),
    );
  }
}
