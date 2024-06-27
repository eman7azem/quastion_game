class Point {
  final int id;
  final int point;
  final DateTime createdAt;
  final DateTime updatedAt;

  Point({
    required this.id,
    required this.point,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(
      id: json['id'] is int ? json['id'] : int.parse(json['id']),
      point: json['point'] is int ? json['point'] : int.parse(json['point']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'point': point,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}