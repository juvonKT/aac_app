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
    if (userIdsString != null && usersString != null) {
      try {
        _userIds = List<String>.from(jsonDecode(userIdsString));
        _users = List<String>.from(jsonDecode(usersString));

        String? userLanguagesString = prefs.getString('userLanguages');
        String? userThemesString = prefs.getString('userThemes');

        _userLanguages = userLanguagesString != null
            ? Map<String, String>.from(jsonDecode(userLanguagesString))
            : {};
        _userThemes = userThemesString != null
            ? Map<String, String>.from(jsonDecode(userThemesString))
            : {};
      } catch (e) {
        print("Error decoding user data: $e");
        _userIds = [];
        _users = [];
        _userLanguages = {};
        _userThemes = {};
      }
    } else {
      print("No user data found in SharedPreferences");
      _userIds = [];
      _users = [];
      _userLanguages = {};
      _userThemes = {};
    }

    _selectedUser = prefs.getString('selectedUser');
    _selectedUserId = prefs.getString('selectedUserId');
    _selectedLanguage = prefs.getString('selectedUserLanguage');
    _selectedTheme = prefs.getString('selectedUserTheme');

    print("LOADING USERS");
    print("selectedUser: $_selectedUser");
    print("selectedUserId: $_selectedUserId");
    print("selectedLanguage: $_selectedLanguage");
    print("selectedTheme: $_selectedTheme");

    notifyListeners();
  }

  Future<void> addUser(String userId, String userName, String languageCode, String userTheme) async {
    print("Before adding user - _userIds: $_userIds");
    print("Before adding user - _users: $_users");

    if (!_users.contains(userName)) {
      List<String> updatedUserIds = List<String>.from(_userIds)..add(userId);
      List<String> updatedUsers = List<String>.from(_users)..add(userName);

      print("Before saving - updatedUserIds: $updatedUserIds");
      print("Before saving - updatedUsers: $updatedUsers");

      final prefs = await SharedPreferences.getInstance();

      // Save users first
      await prefs.setString('users', jsonEncode(updatedUsers));
      print("After saving users - updatedUserIds: $updatedUserIds");

      // Save userIds
      await prefs.setString('userIds', jsonEncode(updatedUserIds));
      print("After saving userIds - updatedUserIds: $updatedUserIds");

      // Update the rest of the data
      _userIds = updatedUserIds;
      _users = updatedUsers;
      _userLanguages[userId] = languageCode;
      _userThemes[userId] = userTheme;
      _selectedUser = userName;
      _selectedUserId = userId;
      _selectedLanguage = languageCode;
      _selectedTheme = userTheme;

      await prefs.setString('userLanguages', jsonEncode(_userLanguages));
      await prefs.setString('userThemes', jsonEncode(_userThemes));

      // Save selected user data
      await prefs.setString('selectedUser', _selectedUser ?? '');
      await prefs.setString('selectedUserId', _selectedUserId ?? '');
      await prefs.setString('selectedUserLanguage', _selectedLanguage ?? '');
      await prefs.setString('selectedUserTheme', _selectedTheme ?? '');

      print("After saving all data - _userIds: $_userIds");
      print("Verification - Saved userIds: ${prefs.getString('userIds')}");
      print("Verification - Saved users: ${prefs.getString('users')}");

      notifyListeners();
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
  String getLanguageCode() {
    return _selectedLanguage ?? 'en'; // Default to English if no language is set
  }

  String getTheme() {
    return _selectedTheme ?? 'light'; // Default to light theme if no theme is set
  }

}
