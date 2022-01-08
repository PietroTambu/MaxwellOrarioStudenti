class Classes {
  final List min;
  final List complete;

  Classes({
    required this.min,
    required this.complete,
  });

  factory Classes.fromJson(Map<String, dynamic> json) {
    return Classes(
        min: json['min'],
        complete: json['complete'],
    );
  }
}
