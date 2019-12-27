import 'package:flutter/foundation.dart';

class CarModel {
  final String _name;
  final String _photoUrl;

  String get name => _name;
  String get photoUrl => _photoUrl;

  CarModel({@required String name, @required String photoUrl})
      : _name = name,
        _photoUrl = photoUrl;

  factory CarModel.fromJson(Map<dynamic, dynamic> json) {
    if (json == null) return null;
    return CarModel(name: json['name'], photoUrl: json['photoUrl']);
  }
}
