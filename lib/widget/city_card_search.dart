import 'package:flutter/material.dart';
import 'package:primeiroaplicativo/screens/citydetails_page.dart';

class CityCardSearch extends StatelessWidget {
  final String name;

  const CityCardSearch({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
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
