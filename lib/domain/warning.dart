class Warning {
  late String title;
  late String description;
  late int level;

  Warning({
    required this.title,
    required this.description,
    required this.level,
  });

  Warning.fromJson(Map<String, dynamic> json) {
    title = (json['title']).toString();
    description = (json['description']).toString();
    level = json['level'] as int;
  }
}
