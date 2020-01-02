import 'package:grad/models/appointment.dart';
import 'package:grad/models/brand.dart';
import 'package:grad/models/car_model.dart';

import 'car.dart';

class User {
  final String _uid;
  final String _name;
  final String _email;
  final String _phonenumber;
  final String _title;
  final Appointment _appointment;
  final List<Car> _cars;

  String get uid => _uid;
  String get email => _email;
  String get name => _name;
  String get phoneNumber => _phonenumber;
  String get title => _title;
  List<Car> get cars => _cars;
  Appointment get appointment => _appointment;

  User(
      {String name,
      String uid,
      String email,
      String phoneNumber,
      String title,
      Appointment appointment,
      List<Car> cars})
      : _name = name,
        _email = email,
        _phonenumber = phoneNumber,
        _title = title,
        _cars = cars,
        _appointment = appointment,
        _uid = uid;

  User copyWith(
      {String name,
      String email,
      String phoneNumber,
      String title,
      Appointment appointment,
      List<Car> cars}) {
    return User(
      name: name ?? this._name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this._phonenumber,
      title: title ?? this._title,
      cars: cars ?? this._cars,
      appointment: appointment ?? this._appointment,
    );
  }

  factory User.fromJson(Map<dynamic, dynamic> json) {
    if (json == null) return null;
    return User(
      uid: json['uid'],
      name: json['displayName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      title: json['title'],
      appointment: Appointment.fromJson(json['appointment']),
      cars: json['cars'] == null
          ? null
          : List.castFrom<dynamic, Car>(json['cars'].map((obj) {
              Brand brand = Brand.fromJson(obj['brand']);
              CarModel model = CarModel.fromJson(obj['model']);
              return Car.from(brand, model);
            }).toList()),
    );
  }
}
