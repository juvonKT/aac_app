import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  List<String> _users = [];
  List<String> _userIds = [];
  String? _selectedUser;
  String? _selectedUserId;

  List<String> get users => _users;
  List<String> get userIds => _userIds;
  String? get selectedUser => _selectedUser;
  String? get selectedUserId => _selectedUserId;

  UserProvider() {
    loadUserData();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    String? userIdsString = prefs.getString('userIds');
    String? usersString = prefs.getString('users');

    if (userIdsString != null && usersString != null) {
      _userIds = List<String>.from(jsonDecode(userIdsString));
      _users = List<String>.from(jsonDecode(usersString));
    }

    _selectedUser = prefs.getString('selectedUser');
    _selectedUserId = prefs.getString('selectedUserId');

    notifyListeners();
  }

  Future<void> addUser(String userId, String userName) async {
    if (!_users.contains(userName)) {
      _userIds.add(userId);
      _users.add(userName);
      _selectedUser = userName;
      _selectedUserId = userId;

      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('users', jsonEncode(_users));
      await prefs.setString('userIds', jsonEncode(_userIds));
    }
  }

  Future<void> selectUser(String? userName, String? userId) async {
    _selectedUser = userName;
    _selectedUserId = userId;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedUser', _selectedUser ?? '');
    await prefs.setString('selectedUserId', _selectedUserId ?? '');
  }

  Future<void> deleteUser(String userName) async {
    int index = _users.indexOf(userName);
    if (index != -1) {
      _users.removeAt(index);
      _userIds.removeAt(index);

      if (_selectedUser == userName) {
        _selectedUser = null;
        _selectedUserId = null;
      }

      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('users', jsonEncode(_users));
      await prefs.setString('userIds', jsonEncode(_userIds));

      if (_selectedUser == null) {
        prefs.remove('selectedUser');
        prefs.remove('selectedUserId');
      }
    }
  }
}
