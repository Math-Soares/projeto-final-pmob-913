class City {
  late String name;
  late String state;
  late bool favorite;
  late int degrees;
  late int min;
  late int max;
  late int uv;
  late int pre;
  late String condition;
  late int humidity;
  late double wind;
  late int feelsLike;
  late double pressure;
  late double visibility;
  late bool isMyLocation;

  City({
    required this.name,
    required this.state,
    required this.favorite,
    required this.degrees,
    required this.min,
    required this.max,
    required this.uv,
    required this.pre,
    required this.condition,
    required this.humidity,
    required this.wind,
    required this.feelsLike,
    required this.pressure,
    required this.visibility,
    required this.isMyLocation,
  });

  String get uvTexto {
    if (uv >= 11) return 'Extremo';
    if (uv >= 8) return 'Muito Alto';
    if (uv >= 6) return 'Alto';
    if (uv >= 3) return 'Moderado';

    return 'Baixo';
  }

  City.fromJson(Map<String, dynamic> json) {
    name = json['name'].toString();
    state = json['state'].toString();
    favorite = (json['favorite'] as int) != 0;
    degrees = (json['degrees'] as num).toInt();
    min = (json['min'] as num).toInt();
    max = (json['max'] as num).toInt();
    uv = (json['uv'] as num).toInt();
    pre = (json['pre'] as num).toInt();
    condition = json['condition'].toString();
    humidity = (json['humidity'] as num).toInt();
    wind = (json['wind'] as num).toDouble();
    feelsLike = (json['feelsLike'] as num).toInt();
    pressure = (json['pressure'] as num).toDouble();
    visibility = (json['visibility'] as num).toDouble();
    isMyLocation = (json['isMyLocation'] as int) != 0;
  }
}
