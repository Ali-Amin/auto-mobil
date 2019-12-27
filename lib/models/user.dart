import 'package:grad/models/brand.dart';

class User {
  final String _name;
  final String _email;
  final String _phonenumber;
  final Brand _brand;

  String get email => _email;
  String get name => _name;
  String get phoneNumber => _phonenumber;
  Brand get brand => _brand;

  User({String name, String email, String phoneNumber, Brand brand})
      : _name = name,
        _email = email,
        _phonenumber = phoneNumber,
        _brand = brand;

  User copyWith({String name, String email, String phoneNumber, Brand brand}) {
    return User(
      name: name ?? this._name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this._phonenumber,
      brand: brand ?? this._brand,
    );
  }

  factory User.fromJson(Map<dynamic, dynamic> json) {
    if (json == null) return null;
    return User(
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      brand: Brand.fromJson(json['brand']),
    );
  }
}
