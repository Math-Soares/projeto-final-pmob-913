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
  });

  City.fromJson(Map<String, dynamic> json) {
    name = (json['name']).toString();
    state = (json['state']).toString();
    favorite = (json['favorite'] as int) != 0;
    degrees = json['degrees'] as int;
    min = json['min'] as int;
    max = json['max'] as int;
    uv = json['uv'] as int;
    pre = json['pre'] as int;
    condition = (json['condition']).toString();
    humidity = json['humidity'] as int;
    wind = json['wind'] as double;
    feelsLike = json['feelsLike'] as int;
    pressure = json['pressure'] as double;
    visibility = json['visibility'] as double;
  }
}