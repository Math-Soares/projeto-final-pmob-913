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
  List<City> listFavoritesCitys = [];

  @override
  void initState() {
    super.initState();
    // É necessário pois o initState não permite parar a tela (uso do await)
    loadData();
  }

  // Carregar os dados do Banco de Dados
  Future<void> loadData() async {
    listFavoritesCitys = await CityDao().listFavoritesCitys();
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
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

            ListView.builder(
              shrinkWrap: true,
              itemCount: listFavoritesCitys.length,
              itemBuilder: (context, i) {
                return _cidadeFavoritaCard(
                  cidade:
                      '${listFavoritesCitys[i].name}, ${listFavoritesCitys[i].state}',
                  clima: listFavoritesCitys[i].condition,
                  temperatura: '${listFavoritesCitys[i].degrees}°',
                  isLocalizacaoAtual: listFavoritesCitys[i].isMyLocation,
                );
              },
            ),

            _adicionarCidadeCard(),
          ],
        ),
      ),
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
