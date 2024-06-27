import 'dart:io';
import 'package:flutter/material.dart';

class UserData {
  final String name;
  final String nickname;
  final String phone;
  final String email;
  String? image;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;
  final int userId;

  UserData({
    required this.name,
    required this.nickname,
    required this.phone,
    required this.email,
    this.image,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.userId,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['name'],
      nickname: json['nickname'],
      phone: json['phone'],
      email: json['email'],
      image: json['image'],
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
      id: json['id'],
      userId: json['user_id'],
    );
  }

  UserData copyWith({
    String? name,
    String? nickname,
    String? phone,
    String? email,
    String? image,
    DateTime? updatedAt,
    DateTime? createdAt,
    int? id,
    int? userId,
  }) {
    return UserData(
      name: name ?? this.name,
      nickname: nickname ?? this.nickname,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      image: image ?? this.image,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      userId: userId ?? this.userId,
    );
  }
}