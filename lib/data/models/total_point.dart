import 'dart:convert';
class TotalPointsData {
  final int id;
  final int total;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User user;

  TotalPointsData({
    required this.id,
    required this.total,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory TotalPointsData.fromJson(Map<String, dynamic> json) {
    return TotalPointsData(
      id: json['id'],
      total: json['total'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      user: User.fromJson(json['user']),
    );
  }
}
class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final dynamic emailVerifiedAt;
  final String status;
  final dynamic code;
  final dynamic expireAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    this.emailVerifiedAt,
    required this.status,
    this.code,
    this.expireAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      emailVerifiedAt: json['email_verified_at'],
      status: json['status'],
      code: json['code'],
      expireAt: json['expire_at'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
