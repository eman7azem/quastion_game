class User {
  final String name;
  final String nickname;
  final String phone;
  final String email;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;
  final int userId;

  User({
    required this.name,
    required this.nickname,
    required this.phone,
    required this.email,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.userId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      nickname: json['nickname'],
      phone: json['phone'],
      email: json['email'],
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
      id: json['id'],
      userId: json['user_id'],
    );
  }
}
