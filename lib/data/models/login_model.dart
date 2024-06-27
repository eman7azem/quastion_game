class LoginResponse {
  final bool success;
  final LoginData data;
  final String message;

  LoginResponse({required this.success, required this.data, required this.message});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'],
      data: LoginData.fromJson(json['data']),
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.toJson(),
      'message': message,
    };
  }
}

class LoginData {
  final String token;
  final int id;
  final String name;
  final String phone;
  final String email;

  LoginData({required this.token, required this.id, required this.name, required this.phone, required this.email});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      token: json['token'],
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
    };
  }
}
