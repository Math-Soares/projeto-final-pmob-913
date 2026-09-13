import 'package:albedo/api/city_api.dart';
import 'package:albedo/db/shared_prefs.dart';
import 'package:albedo/screens/citydetails_page.dart';
import 'package:flutter/material.dart';

class CityCardSearch extends StatefulWidget {
  final String name;
  final String state;

  const CityCardSearch({super.key, required this.name, required this.state});

  @override
  State<CityCardSearch> createState() => _CityCardSearchState();
}

class _CityCardSearchState extends State<CityCardSearch> {
  bool isFav = false;

  @override
  void initState() {
    super.initState();
    SharedPrefs().isFavorite('${widget.name} - ${widget.state}').then((v) {
      if (mounted) setState(() => isFav = v);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text('${widget.name} - ${widget.state}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(isFav ? Icons.star : Icons.star_border),
              color: isFav ? Colors.amber : null,
              onPressed: () async {
                final key = '${widget.name} - ${widget.state}';
                if (isFav) {
                  await SharedPrefs().removeFavorite(key);
                } else {
                  await SharedPrefs().addFavorite(key);
                }
                setState(() => isFav = !isFav);
              },
            ),
            Icon(Icons.arrow_outward_rounded),
          ],
        ),
        onTap: () async {
          final city = await CityApi().fetchWeatherData(widget.name);
          if (!context.mounted) return;
          if (city == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Não foi possivel carregar "${widget.name}"'),
              ),
            );
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CityDetailsPage(city: city)),
          );
        },
      ),
    );
  }
}
