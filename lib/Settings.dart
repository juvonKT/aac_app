import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'UserGuidePage.dart';
import 'generated/l10n.dart';
import 'providers/language_provider.dart';
import 'providers/theme_provider.dart';
import 'StartingPage.dart';
import 'user_provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String selectedUser = 'Add New User';

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final s = S.of(context);
    final userProvider = Provider.of<UserProvider>(context);
    final userList = userProvider.users;
    String? selectedUser = userProvider.selectedUser ?? 'Add New User';
    String? selectedUserId = userProvider.selectedUserId;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          s.setting,
          style: TextStyle(color: Theme.of(context).appBarTheme.foregroundColor),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: DropdownButton<String>(
              value: selectedUser,
              onChanged: (String? newValue) {
                if (newValue != null && newValue != 'Add New User') {
                  userProvider.selectUser(newValue);
                }
                if (newValue == 'Add New User') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StartingPage(),
                    ),
                  );
                }
              },
              items: [
                ...userList.map((user) => DropdownMenuItem<String>(
                  value: user,
                  child: Text(user),
                )),
                const DropdownMenuItem<String>(
                  value: 'Add New User',
                  child: Text('Add New User'),
                ),
              ],
              isExpanded: true,
            ),
          ),

          if (selectedUser != 'Add New User' && selectedUser != null)
            ListTile(
              title: ElevatedButton(
                onPressed: () {
                  ShowDeleteConfirmation(context, selectedUser!, userProvider);
                },
                child: Text('Delete User'),
              ),
            ),

          const Divider(),
          ListTile(
            title: Text(s.language),
            subtitle: Text(_getLanguageName(languageProvider.currentLocale)),
            trailing: DropdownButton<Locale>(
              value: languageProvider.currentLocale,
              onChanged: (Locale? newValue) {
                if (newValue != null) {
                  languageProvider.setLocale(newValue);
                }
              },
              items: const [
                DropdownMenuItem(value: Locale('en', ''), child: Text('English')),
                DropdownMenuItem(value: Locale('ms', ''), child: Text('Malay')),
                DropdownMenuItem(value: Locale('zh', ''), child: Text('Mandarin')),
                DropdownMenuItem(value: Locale('ja', ''), child: Text('Japanese')),
              ],
              underline: const SizedBox(),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: Text(s.colourScheme),
            subtitle: Text(_getThemeModeName(themeProvider.themeMode, s)),
            trailing: DropdownButton<ThemeMode>(
              value: themeProvider.themeMode,
              onChanged: (ThemeMode? newMode) {
                if (newMode != null) {
                  themeProvider.setTheme(newMode);
                }
              },
              items: [
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text(s.light),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text(s.dark),
                ),
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text(s.colourPaletteGenerator),
                ),
              ],
              underline: const SizedBox(),
            ),
          ),
          const Divider(),
          ListTile(
            title: Text(s.userGuide),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserGuidePage()),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: s.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: s.setting,
          ),
        ],
        backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
      ),
    );
  }

  String _getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'ms':
        return 'Malay';
      case 'zh':
        return 'Mandarin';
      case 'ja':
        return 'Japanese';
      default:
        return 'Unknown';
    }
  }

  void ShowDeleteConfirmation(BuildContext context, String userName, UserProvider userProvider) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete User'),
          content: Text('Are you sure you want to delete $userName?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                userProvider.deleteUser(userName);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  String _getThemeModeName(ThemeMode mode, S s) {
    switch (mode) {
      case ThemeMode.light:
        return s.light;
      case ThemeMode.dark:
        return s.dark;
      case ThemeMode.system:
      default:
        return s.light;
    }
  }
}
