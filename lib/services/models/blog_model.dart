import 'dart:convert';

import 'package:equatable/equatable.dart';

class Blog extends Equatable {
  final int userId;
  final int? id;
  final String title;
  final String body;
  const Blog({
    required this.userId,
    this.id,
    required this.title,
    required this.body,
  });

  @override
  List<Object> get props => [userId, title, body];

  Blog copyWith({
    int? userId,
    int? id,
    String? title,
    String? body,
  }) {
    return Blog(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'body': body,
    };
  }

  factory Blog.fromMap(Map<String, dynamic> map) {
    return Blog(
      userId: map['userId']?.toInt() ?? 0,
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      body: map['body'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Blog.fromJson(String source) => Blog.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Blog(userId: $userId, id: $id, title: $title, body: $body)';
  }
}
