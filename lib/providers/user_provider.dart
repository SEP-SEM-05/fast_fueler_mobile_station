import 'dart:collection';

import 'package:fast_fueler_mobile_station/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    registrationNo: '',
    name: '',
    password: '',
    contactNo: '',
    location: '',
    company: '',
    email: '',
    isRegistered: false,
    isNew: false,
    capasities: LinkedHashMap(),
    volumes: LinkedHashMap(),
    lastFilled: LinkedHashMap(),
    lastAnnounced: LinkedHashMap(),
    token: '',
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
