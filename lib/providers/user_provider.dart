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

    // Load the selected user's language and theme
    if (_selectedUserId != null) {
      _selectedLanguage = _userLanguages[_selectedUserId];
      _selectedTheme = _userThemes[_selectedUserId];
    } else {
      _selectedLanguage = prefs.getString('selectedUserLanguage');
      _selectedTheme = prefs.getString('selectedUserTheme');
    }

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
      // Save userIds
      await prefs.setString('userIds', jsonEncode(updatedUserIds));

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
    if (_selectedUserId != null) {
      _userLanguages[_selectedUserId!] = languageCode;
      _selectedLanguage = languageCode;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userLanguages', jsonEncode(_userLanguages));
      await prefs.setString('selectedUserLanguage', languageCode);
      notifyListeners();
    }
  }

  Future<void> setUserTheme(String theme) async {
    if (_selectedUserId != null) {
      _userThemes[_selectedUserId!] = theme;
      _selectedTheme = theme;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userThemes', jsonEncode(_userThemes));
      await prefs.setString('selectedUserTheme', theme);
      notifyListeners();
    }
  }

  Future<void> selectUser(String? userName) async {
    print("Selecting user: $userName");
    print("Current _users: $_users");
    print("Current _userIds: $_userIds");

    String? newSelectedUserId;

    if (userName != null && userName != 'Add New User') {
      int index = _users.indexOf(userName);
      if (index != -1 && index < _userIds.length) {
        _selectedUser = userName;
        newSelectedUserId = _userIds[index];
        _selectedLanguage = _userLanguages[newSelectedUserId] ?? 'en';
        _selectedTheme = _userThemes[newSelectedUserId] ?? 'light';
      } else {
        print("Error: User $userName found in _users but not in _userIds");
        if (_users.isNotEmpty && _userIds.isNotEmpty) {
          _selectedUser = _users[0];
          newSelectedUserId = _userIds[0];
          _selectedLanguage = _userLanguages[newSelectedUserId] ?? 'en';
          _selectedTheme = _userThemes[newSelectedUserId] ?? 'light';
        } else {
          _selectedUser = null;
          newSelectedUserId = null;
          _selectedLanguage = 'en';
          _selectedTheme = 'light';
        }
      }
    } else {
      _selectedUser = null;
      newSelectedUserId = null;
      _selectedLanguage = 'en';
      _selectedTheme = 'light';
    }

    print("SELECTING USER");
    print("selectedUser: $_selectedUser");
    print("selectedUserId: $newSelectedUserId");
    print("selectedLanguage: $_selectedLanguage");
    print("selectedTheme: $_selectedTheme");

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedUser', _selectedUser ?? '');
    await prefs.setString('selectedUserId', newSelectedUserId ?? '');
    await prefs.setString('selectedUserLanguage', _selectedLanguage ?? 'en');
    await prefs.setString('selectedUserTheme', _selectedTheme ?? 'light');

    _selectedUserId = newSelectedUserId;

    notifyListeners();
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
    return _selectedLanguage ?? 'en';
  }

  String getTheme() {
    return _selectedTheme ?? 'light';
  }

}

