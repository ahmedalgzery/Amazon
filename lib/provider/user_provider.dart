import 'package:amazon/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    type: '',
    token: '',
    cart: [],
  );

  // Getter to access the user data
  User get user => _user;

  // Method to set user data from a JSON representation
  void setUser(String user) {
    _user = User.fromJson(user); // Creating a User instance from JSON data
    notifyListeners(); // Notifying listeners that user data has changed
  }

  // Method to set user data directly from a User object
  void setUserFromModel(User user) {
    _user = user; // Setting user data from the provided User object
    notifyListeners(); // Notifying listeners that user data has changed
  }
}
