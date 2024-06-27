import 'package:flutter/material.dart';

class LocationProvider extends ChangeNotifier {
  String? _location;
  String? _latitude;
  String? _longitude;

  String? get location => _location;
  set location(String? value) {
    _location = value;
    notifyListeners();
  }

  String? get latitude => _latitude;
  set latitude(String? value) {
    _latitude = value;
    notifyListeners();
  }

  String? get longitude => _longitude;
  set longitude(String? value) {
    _longitude = value;
    notifyListeners();
  }
  void setLocation(String newLocation) {
    _location = newLocation;
    notifyListeners();
  }
}
