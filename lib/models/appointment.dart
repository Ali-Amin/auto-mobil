import 'package:flutter/material.dart';
import 'package:grad/models/car.dart';

class Appointment {
  final DateTime _date;
  final String _userUid;
  final String _uid;
  final Car _car;
  final String _comment;
  final String _problem;

  String get uid => _uid;
  String get comment => _comment;
  String get userUid => _userUid;
  DateTime get date => _date;
  Car get car => _car;
  String get problem => _problem;

  Appointment({
    @required DateTime date,
    @required String userUid,
    @required String uid,
    @required Car car,
    @required String problem,
    @required String comment,
  })  : _date = date,
        _userUid = userUid,
        _car = car,
        _uid = uid,
        _problem = problem,
        _comment = comment;

  factory Appointment.fromJson(Map<dynamic, dynamic> json) {
    if (json == null) return null;
    return Appointment(
      car: Car.fromJson(json['car']),
      date: DateTime.fromMillisecondsSinceEpoch(json['date']),
      uid: json['uid'],
      comment: json['comment'],
      userUid: json['userUid'],
      problem: json['problem'],
    );
  }
}
