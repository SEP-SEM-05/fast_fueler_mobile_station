import 'dart:collection';
import 'dart:convert';

class User {
  final String id;
  final String name;
  final String registrationNo;
  final String password;
  final String token;
  final String contactNo;
  final String location;
  final String company;
  final String email;
  final bool isRegistered;
  final bool isNew;
  final LinkedHashMap<String, dynamic> capasities;
  final LinkedHashMap<String, dynamic> volumes;
  final LinkedHashMap<String, dynamic> lastFilled;
  final LinkedHashMap<String, dynamic> lastAnnounced;

  User({
    required this.id,
    required this.name,
    required this.registrationNo,
    required this.password,
    required this.token,
    required this.contactNo,
    required this.location,
    required this.company,
    required this.email,
    required this.isRegistered,
    required this.isNew,
    required this.capasities,
    required this.volumes,
    required this.lastFilled,
    required this.lastAnnounced,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'registrationNo': registrationNo,
      'name': name,
      'password': password,
      'token': token,
      'contactNo': contactNo,
      'location': location,
      'company': company,
      'email': email,
      'isRegistered': isRegistered,
      'isNew': isNew,
      'capasities': capasities,
      'volumes': volumes,
      'lastFilled': lastFilled,
      'lastAnnounced': lastAnnounced,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      registrationNo: map['registrationNo'] ?? '',
      name: map['name'] ?? '',
      password: map['password'] ?? '',
      token: map['token'] ?? '',
      contactNo: map['contactNo'] ?? '',
      location: map['location'] ?? '',
      company: map['company'] ?? '',
      email: map['email'] ?? '',
      isRegistered: map['isRegistered'] ?? '',
      isNew: map['isNew'] ?? '',
      capasities: map['capasities'] ?? '',
      volumes: map['volumes'] ?? '',
      lastFilled: map['lastFilled'] ?? '',
      lastAnnounced: map['lastAnnounced'] ?? '',
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
    String? contactNo,
    String? location,
    String? company,
    String? email,
    bool? isRegistered,
    bool? isNew,
    LinkedHashMap<String, dynamic>? capasities,
    LinkedHashMap<String, dynamic>? volumes,
    LinkedHashMap<String, dynamic>? lastFilled,
    LinkedHashMap<String, dynamic>? lastAnnounced,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      registrationNo: registrationNo ?? this.registrationNo,
      password: password ?? this.password,
      token: token ?? this.token,
      contactNo: contactNo ?? this.contactNo,
      location: location ?? this.location,
      company: company ?? this.company,
      email: email ?? this.email,
      isRegistered: isRegistered ?? this.isRegistered,
      isNew: isNew ?? this.isNew,
      capasities: capasities ?? this.capasities,
      volumes: volumes ?? this.volumes,
      lastFilled: lastFilled ?? this.lastFilled,
      lastAnnounced: lastAnnounced ?? this.lastAnnounced,
    );
  }
}
