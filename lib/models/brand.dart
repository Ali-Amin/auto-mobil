import 'package:flutter/foundation.dart';

class Brand {
  final String _uid;
  final String _name;
  final String _photoUrl;

  String get name => _name;
  String get uid => _uid;
  String get photoUrl => _photoUrl;

  Brand(
      {@required String name, @required String photoUrl, @required String uid})
      : _name = name,
        _uid = uid,
        _photoUrl = photoUrl;

  factory Brand.fromJson(Map<dynamic, dynamic> json) {
    if (json == null) return null;
    return Brand(
      name: json['name'],
      photoUrl: json['photoUrl'],
      uid: json['uid'],
    );
  }
}
