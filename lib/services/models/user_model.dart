import 'dart:convert';

import 'package:equatable/equatable.dart';

class Users extends Equatable {
  final int id;
  final String name;
  final String email;
  final String address;
  final String phone;
  const Users({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
  });

  @override
  List<Object> get props {
    return [id, name, email, address, phone];
  }

  Users copyWith({
    int? id,
    String? name,
    String? email,
    String? address,
    String? phone,
  }) {
    return Users(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      address: address ?? this.address,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'address': address,
      'phone': phone,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      address: map['address']['street'] ?? '',
      phone: map['phone'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String source) => Users.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Users(id: $id, name: $name, email: $email, address: $address, phone: $phone)';
  }
}
