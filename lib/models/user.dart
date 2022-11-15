import 'dart:convert';

class User {
  final String id;
  final String name;
  final String registrationNo;
  final String password;
  final String token;

  User({
    required this.id,
    required this.name,
    required this.registrationNo,
    required this.password,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': registrationNo,
      'password': password,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      registrationNo: map['email'] ?? '',
      password: map['password'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? name,
    String? registrationNo,
    String? password,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      registrationNo: registrationNo ?? this.registrationNo,
      password: password ?? this.password,
      token: token ?? this.token,
    );
  }
}
