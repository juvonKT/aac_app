import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  List<String> _users = [];
  String? _selectedUser;

  List<String> get users => _users;

  String? get selectedUser => _selectedUser;

  void addUser(String userName) {
    if (!_users.contains(userName)) {
      _users.add(userName);
      _selectedUser = userName;
      notifyListeners();
    }
  }

  void selectUser(String userName) {
    _selectedUser = userName;
    notifyListeners();
  }
}
