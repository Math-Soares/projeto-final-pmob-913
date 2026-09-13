import 'package:albedo/api/city_api.dart';
import 'package:albedo/db/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:albedo/domain/city.dart';

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
    _load();
  }

  void _load() {
    setState(() {
      listFavoritesCities = _loadFavorites();
    });
  }

  Future<List<City>> _loadFavorites() async {
    List<City> favorites = [];

    final keys = await SharedPrefs().getFavorites();
    if (keys.isEmpty) return [];

    for (var key in keys) {
      final name = key.split(RegExp(r'[-,]')).first.trim();
      try {
        final city = await CityApi().fetchWeatherData(name);
        if (city != null) favorites.add(city);
      } catch (_) {
        // ignora cidade com erro e continua as outras
      }
    }

    return favorites;
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
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.blue),
                  );
                }

                if (snapshot.hasError) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Column(
                      children: [
                        Text('Erro ao carregar favoritos'),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: _load,
                          child: Text('Tentar novamente'),
                        ),
                      ],
                    ),
                  );
                }

                if (snapshot.hasData) {
                  List<City> list = snapshot.requireData;
                  if (list.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Column(
                        children: [
                          Icon(Icons.star_border, size: 48, color: Colors.grey),
                          SizedBox(height: 8),
                          Text(
                            'Você ainda não tem favoritos',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Busque uma cidade e toque na estrela',
                            style: GoogleFonts.inter(color: Colors.grey),
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

            //_adicionarCidadeCard(),
          ],
        ),
      ),
    );
  }

  ListView buildListView(List<City> listFavoritesCities) {
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

  Widget adicionarCidadeCard() {
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
