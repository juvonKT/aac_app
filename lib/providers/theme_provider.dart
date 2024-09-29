import 'package:aac_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void setTheme(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  void loadUserTheme(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    String savedTheme = userProvider.getTheme();
    switch (savedTheme) {
      case 'light':
        setTheme(ThemeMode.light);
        break;
      case 'dark':
        setTheme(ThemeMode.dark);
        break;
      case 'system':
        setTheme(ThemeMode.system);
        break;
      default:
        setTheme(ThemeMode.light);
    }
  }

  ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[400],
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey[400],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[200],
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black),
        titleLarge: TextStyle(color: Colors.black),
      ),
      iconTheme: IconThemeData(color: Colors.black),
    );
  }

  ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.black,
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[600],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey[600],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[300],
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white),
        titleLarge: TextStyle(color: Colors.white),
      ),
      iconTheme: IconThemeData(color: Colors.white),
    );
  }
}