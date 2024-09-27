import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  List<String> _users = [];
  List<String> _userIds = [];
  Map<String, String> _userLanguages = {};
  Map<String, String> _userThemes = {};

  String? _selectedUser;
  String? _selectedUserId;
  String? _selectedLanguage;
  String? _selectedTheme;

  List<String> get users => _users;
  List<String> get userIds => _userIds;
  String? get selectedUser => _selectedUser;
  String? get selectedUserId => _selectedUserId;
  String? get selectedLanguage => _selectedLanguage;
  String? get selectedTheme => _selectedTheme;

  UserProvider() {
    loadUserData();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? userIdsString = prefs.getString('userIds');
    String? usersString = prefs.getString('users');
    String? userLanguagesString = prefs.getString('userLanguages');
    String? userThemesString = prefs.getString('userThemes');

    if (userIdsString != null && usersString != null) {
      _userIds = List<String>.from(jsonDecode(userIdsString));
      _users = List<String>.from(jsonDecode(usersString));
      _userLanguages = userLanguagesString != null
          ? Map<String, String>.from(jsonDecode(userLanguagesString))
          : {};
      _userThemes = userThemesString != null
          ? Map<String, String>.from(jsonDecode(userThemesString))
          : {};
    }

    _selectedUser = prefs.getString('selectedUser');
    _selectedUserId = prefs.getString('selectedUserId');
    _selectedLanguage = prefs.getString('selectedUserLanguage');
    _selectedTheme = prefs.getString('selectedUserTheme');

          print("LOADING USERS");
      print(selectedUser);
      print(selectedUserId);
      print(selectedLanguage);
      print(selectedTheme);

      notifyListeners();
    }

    Future<void> addUser(String userId, String userName, String languageCode, String userTheme) async {
      if (!_users.contains(userName)) {
        _userIds.add(userId);
      _users.add(userName);
      _userLanguages[userId] = languageCode;
      _selectedUser = userName;
      _selectedUserId = userId;
      _selectedLanguage = languageCode;
      _selectedTheme = userTheme;

      print("ADDING USER");
      print(selectedUser);
      print(selectedUserId);
      print(selectedLanguage);
      print(selectedTheme);

      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('users', jsonEncode(_users));
      await prefs.setString('userIds', jsonEncode(_userIds));
      await prefs.setString('userLanguages', jsonEncode(_userLanguages));
      await prefs.setString('userThemes', jsonEncode(_userThemes));
    }
  }

  Future<void> setUserLanguage(String languageCode) async {
    _userLanguages[_selectedUserId.toString()] = languageCode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedUserLanguage', languageCode ?? '');
  }

  Future<void> setUserTheme(String theme) async {
    _userThemes[_selectedUserId.toString()] = theme;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedUserTheme', theme ?? '');
  }

  Future<void> selectUser(String? userName) async {
    if (userName != null) {
      int index = _users.indexOf(userName);
      if (index != -1) {
        _selectedUser = userName;
        _selectedUserId = _userIds[index];
        _selectedLanguage = _userLanguages[_selectedUserId];
        _selectedTheme = _userThemes[_selectedUserId];
      }
    } else {
      _selectedUser = null;
      _selectedUserId = null;
      _selectedLanguage = null;
      _selectedTheme = null;
    }

    print("SELECTING USER");
    print(selectedUser);
    print(selectedUserId);
    print(selectedLanguage);
    print(selectedTheme);

    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedUser', _selectedUser ?? '');
    await prefs.setString('selectedUserId', _selectedUserId ?? '');
    await prefs.setString('selectedUserLanguage', _selectedLanguage ?? '');
    await prefs.setString('selectedUserTheme', _selectedTheme ?? '');
  }

  Future<void> deleteUser(String userName) async {
    int index = _users.indexOf(userName);
    if (index != -1) {
      _users.removeAt(index);
      _userIds.removeAt(index);
      _userLanguages.remove(selectedUserId);
      _userThemes.remove(selectedUserId);

      if (_selectedUser == userName) {
        _selectedUser = null;
        _selectedUserId = null;
        _selectedLanguage = null;
        _selectedTheme = null;
      }

      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('users', jsonEncode(_users));
      await prefs.setString('userIds', jsonEncode(_userIds));
      await prefs.setString('userLanguages', jsonEncode(_userLanguages));
      await prefs.setString('userThemes', jsonEncode(_userThemes));

      if (_selectedUser == null) {
        prefs.remove('selectedUser');
        prefs.remove('selectedUserId');
        prefs.remove('selectedUserLanguage');
        prefs.remove('selectedUserTheme');
      }
    }
  }

}
