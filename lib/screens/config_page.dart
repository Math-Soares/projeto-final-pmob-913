import 'package:albedo/api/city_api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:albedo/db/shared_prefs.dart';
import 'package:albedo/widget/build_card_config.dart';
import 'package:albedo/widget/build_list_tile_config.dart';
import 'package:albedo/widget/build_segment_config.dart';
import 'package:albedo/widget/section_title_config.dart';

import 'login_page.dart';

class ConfigPage extends StatefulWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;

  const ConfigPage({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
  });

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  SharedPrefs prefs = SharedPrefs();
  bool alertas = false;
  bool previsao = false;
  //bool gps = false;

  String temperatura = '°C';
  String horario = '24h';

  bool _loadingLoc = false;

  TextEditingController locAtual = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadSavedLoc();
  }

  @override
  void dispose() {
    locAtual.dispose();
    super.dispose();
  }

  Future<void> loadSavedLoc() async {
    final saved = await prefs.getCurrentCity();

    if (!mounted) return;

    setState(() {
      locAtual.text = saved;
    });
  }

  Future<void> saveLocation(String raw) async {
    final nome = raw.trim();

    if (nome.isEmpty) return;

    setState(() => _loadingLoc = true);

    try {
      final city = await CityApi().fetchWeatherData(nome, isMyLocation: true);

      if (!mounted) return;

      if (city == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cidade "$nome" não encontrada')),
        );
        return;
      }

      await prefs.setCurrentCity(city.name);

      if (!context.mounted) return;

      setState(() {
        locAtual.text = city.name;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Localização atual: ${city.name}')),
      );
    } finally {
      if (mounted) {
        setState(() => _loadingLoc = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          Text(
            'Configurações',
            style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w700),
          ),

          SectionTitleConfig(text: 'TEMPERATURA'),

          BuildCardConfig(
            child: BuildSegmentConfig(
              isDark: widget.isDark,
              leftLabel: '°C',
              rightLabel: '°F',
              selected: temperatura,
              onChanged: (v) => setState(() => temperatura = v),
            ),
          ),

          SectionTitleConfig(text: 'HORÁRIO'),

          BuildCardConfig(
            child: BuildSegmentConfig(
              isDark: widget.isDark,
              leftLabel: '24h',
              rightLabel: '12h',
              selected: horario,
              onChanged: (v) => setState(() => horario = v),
            ),
          ),

          SectionTitleConfig(text: 'APARÊNCIA'),

          BuildCardConfig(
            child: BuildListTileConfig(
              title: 'Tema escuro',
              subtitle: widget.isDark ? 'Ativado' : 'Desativado',
              value: widget.isDark,
              onChanged: widget.onThemeChanged,
            ),
          ),

          SectionTitleConfig(text: 'NOTIFICAÇÕES'),

          BuildCardConfig(
            child: BuildListTileConfig(
              title: 'Alertas climáticos',
              subtitle: 'Tempestades e eventos',
              value: alertas,
              onChanged: (v) => setState(() => alertas = v),
            ),
          ),

          BuildCardConfig(
            child: BuildListTileConfig(
              title: 'Previsão diária',
              subtitle: 'Todos os dias às 7h',
              value: previsao,
              onChanged: (v) => setState(() => previsao = v),
            ),
          ),

          SectionTitleConfig(text: 'LOCALIZAÇÃO'),

          BuildCardConfig(
            child: ListTile(
              title: Text(
                'Localização atual',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: TextField(
                controller: locAtual,
                enabled: !_loadingLoc,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'Digite a localização atual',
                  border: InputBorder.none,
                  suffixIcon:
                      _loadingLoc
                          ? SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          )
                          : Icon(Icons.check),
                ),
                onSubmitted: saveLocation,
              ),
            ),
          ),

          /*
          BuildCardConfig(
            child: BuildListTileConfig(
              title: 'Usar GPS',
              subtitle: 'Localização precisa',
              value: gps,
              onChanged: (v) => setState(() => gps = v),
            ),
          ),
          */
          ElevatedButton(
            onPressed: () async {
              await prefs.setUserStatus(false);

              if (!context.mounted) return;

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginPage();
                  },
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              disabledBackgroundColor: Colors.red.withValues(alpha: 0.9),
              disabledForegroundColor: Colors.white,
              elevation: 4,
              shadowColor: Colors.black.withValues(alpha: 0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.zero,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Center(
                child: Text(
                  'Logout',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
