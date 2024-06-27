import 'package:quastions_game/data/models/point.dart';

class SuccessResponse {
  final bool success;
  final PointUser data;
  final String message;

  SuccessResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory SuccessResponse.fromJson(Map<String, dynamic> json) {
    return SuccessResponse(
      success: json['success'],
      data: PointUser.fromJson(json['data']),
      message: json['message'],
    );
  }
}

class PointUser {
  final int id;
  final int pointId;
  final int userId;
  final DateTime updatedAt;
  final DateTime createdAt;
  final Point point;

  PointUser({
    required this.id,
    required this.pointId,
    required this.userId,
    required this.updatedAt,
    required this.createdAt,
    required this.point,
  });

  factory PointUser.fromJson(Map<String, dynamic> json) {
    return PointUser(
      id: json['id'] is int ? json['id'] : int.parse(json['id']),
      pointId: json['point_id'] is int ? json['point_id'] : int.parse(json['point_id']),
      userId: json['user_id'] is int ? json['user_id'] : int.parse(json['user_id']),
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
      point: Point.fromJson(json['point']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'point_id': pointId,
      'user_id': userId,
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'point': point.toJson(),
    };
  }
}