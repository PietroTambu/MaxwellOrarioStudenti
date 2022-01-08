class Lessons {
  final String name;
  final Object version;
  final List week_days;

  Lessons({
    required this.name,
    required this.version,
    required this.week_days,
  });

  factory Lessons.fromJson(Map<String, dynamic> json) {
    return Lessons(
        name: json['classe'],
        version: {
          json['version']['date'],
          json['version']['number'],
        },
        week_days: [
          json['monday'],
          json['tuesday'],
          json['wednesday'],
          json['thursday'],
          json['friday'],
          json['saturday'],
        ]
    );
  }
}
