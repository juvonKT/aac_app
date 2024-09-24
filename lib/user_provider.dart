import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider with ChangeNotifier {
  List<String> _users = [];
  List<String> _usersIds = [];
  String? _selectedUser;
  String? _selectedUserId;
  Map<String, List<String>> _userPhrases = {}; // Store phrases for each user

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
      _userPhrases[userName] = []; // Initialize phrases list for new user
      notifyListeners();
    }
  }

  void selectUser(String userName) {
    _selectedUser = userName;
    notifyListeners();
  }

  void selectUserId(String userId) {
    _selectedUserId = userId;
    notifyListeners();
  }

  void addPhrase(String phrase) {
    if (_selectedUser != null) {
      _userPhrases[_selectedUser]?.add(phrase); // Add phrase to the current user's list
      // _savePhraseToFirestore(_selectedUser!, phrase); // Save to Firestore
      notifyListeners();
    }
  }

}
