import 'package:grad/models/brand.dart';

class User {
  final String _uid;
  final String _name;
  final String _email;
  final String _phonenumber;
  final String _title;
  final Brand _brand;
  String get uid => _uid;
  String get email => _email;
  String get name => _name;
  String get phoneNumber => _phonenumber;
  String get title => _title;
  Brand get brand => _brand;

  User(
      {String name,
      String uid,
      String email,
      String phoneNumber,
      String title,
      Brand brand})
      : _name = name,
        _email = email,
        _phonenumber = phoneNumber,
        _title = title,
        _uid = uid,
        _brand = brand;

  User copyWith(
      {String name,
      String email,
      String phoneNumber,
      String title,
      Brand brand}) {
    return User(
      name: name ?? this._name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this._phonenumber,
      title: title ?? this._title,
      brand: brand ?? this._brand,
    );
  }

  factory User.fromJson(Map<dynamic, dynamic> json) {
    if (json == null) return null;
    return User(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      title: json['title'],
      brand: Brand.fromJson(json['brand']),
    );
  }
}
