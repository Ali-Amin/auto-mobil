import 'package:grad/models/brand.dart';
import 'package:grad/models/car_model.dart';

class Car {
  final Brand _brand;
  final CarModel _model;

  Brand get brand => _brand;
  CarModel get model => _model;

  Car({Brand brand, CarModel model})
      : _brand = brand,
        _model = model;

  factory Car.from(Brand brand, CarModel model) {
    return Car(brand: brand, model: model);
  }

  factory Car.fromJson(Map<dynamic, dynamic> json) {
    if (json == null) return null;
    return Car(
      brand: Brand.fromJson(json['brand']),
      model: CarModel.fromJson(
        json['model'],
      ),
    );
  }
}
