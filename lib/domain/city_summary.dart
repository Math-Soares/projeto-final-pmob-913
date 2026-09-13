class CitySummary {
  late int id;
  late String name;
  late String state;

  CitySummary({required this.id, required this.name, required this.state});

  CitySummary.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    name = (json['name']).toString();
    state = (json['state']).toString();
  }
}
