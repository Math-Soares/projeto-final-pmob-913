class WeeklyForecast {
  final String day;
  final int min;
  final int max;

  WeeklyForecast({
    required this.day,
    required this.min,
    required this.max,
  });

  factory WeeklyForecast.fromJson(Map<String, dynamic> json) {
    return WeeklyForecast(
      day: json['day'],
      min: json['min'],
      max: json['max'],
    );
  }
}