import 'package:flutter/foundation.dart';

class CarModel {
  final String _name;
  final String _uid;
  final String _photoUrl;

  String get name => _name;
  String get photoUrl => _photoUrl;
  String get uid => _uid;

  CarModel(
      {@required String name, @required String photoUrl, @required String uid})
      : _name = name,
        _uid = uid,
        _photoUrl = photoUrl;

  factory CarModel.fromJson(Map<dynamic, dynamic> json) {
    if (json == null) return null;
    return CarModel(
        name: json['name'], photoUrl: json['photoUrl'], uid: json['uid']);
  }
}
