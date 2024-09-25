import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  List<String> _users = [];
  List<String> _usersIds = [];
  String? _selectedUser;
  String? _selectedUserId;
  Map<String, List<String>> _userPhrases = {};

  List<String> get users => _users;
  List<String> get usersIds => _usersIds;
  String? get selectedUser => _selectedUser;
  String? get selectedUserId => _selectedUserId;
  List<String> get phrasesForSelectedUser => _userPhrases[_selectedUser] ?? [];

  void addUser(String userId, String userName) {
    if (!_users.contains(userName)) {
      _usersIds.add(userId);
      _users.add(userName);
      _selectedUser = userName;
      _selectedUserId = userId;
      _userPhrases[userName] = [];
      notifyListeners();
    }
  }

  void selectUser(String userName) {
    _selectedUser = userName;
    notifyListeners();
  }

  void deleteUser(String userName) {
    int index = _users.indexOf(userName);
    if (index != -1) {
      _users.removeAt(index);
      _usersIds.removeAt(index);
      _userPhrases.remove(userName);

      if (_selectedUser == userName) {
        _selectedUser = null;
        _selectedUserId = null;
      }
      notifyListeners();
    }
  }

  void addPhrase(String phrase) {
    if (_selectedUser != null) {
      _userPhrases[_selectedUser]?.add(phrase);
      notifyListeners();
    }
  }
}

