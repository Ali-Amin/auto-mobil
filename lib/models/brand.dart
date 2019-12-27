import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

class Brand {
  final String _name;
  final String _photoUrl;

  String get name => _name;
  String get photoUrl => _photoUrl;

  Brand({@required String name, @required String photoUrl})
      : _name = name,
        _photoUrl = photoUrl;

  factory Brand.fromJson(Map<dynamic, dynamic> json) {
    if (json == null) return null;
    return Brand(name: json['name'], photoUrl: json['photoUrl']);
  }
}
