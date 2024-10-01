import 'package:aac_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'UserGuidePage.dart';
import 'generated/l10n.dart';
import 'providers/language_provider.dart';
import 'providers/theme_provider.dart';
import 'StartingPage.dart';
import 'providers/user_provider.dart';

class Settings extends StatefulWidget {
  final Function() onLanguageChanged;

  const Settings({Key? key, required this.onLanguageChanged}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final s = S.of(context);
    final userProvider = Provider.of<UserProvider>(context);
    final userList = userProvider.users;
    String selectedUser = userProvider.selectedUser ?? s.addNewUser;

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
              value: userList.contains(selectedUser) ? selectedUser : null,
              hint: Text(s.selectUser),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  if (newValue == s.addNewUser) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StartingPage(
                          onUserCreated: () {
                            widget.onLanguageChanged();
                          },
                        ),
                      ),
                    );
                  } else {
                    userProvider.selectUser(newValue);
                    languageProvider.loadUserLanguage(userProvider);
                    themeProvider.loadUserTheme(context);
                    widget.onLanguageChanged();
                    setState(() {});
                  }
                }
              },
              items: [
                ...userList.map((user) => DropdownMenuItem<String>(
                  value: user,
                  child: Text(user),
                )),
                 DropdownMenuItem<String>(
                  value: s.addNewUser,
                  child: Text(s.addNewUser),
                ),
              ],
            ),
          ),

          if (selectedUser != s.addNewUser && selectedUser != null)
            ListTile(
              title: ElevatedButton(
                onPressed: () {
                  ShowDeleteConfirmation(context, selectedUser!, userProvider, s);
                },
                child: Text(s.deleteUser),
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
                  userProvider.setUserLanguage(newValue.languageCode);
                  widget.onLanguageChanged();
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
                  userProvider.setUserTheme(newMode.toString().split('.').last);
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
                  child: Text(s.system),
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

  void ShowDeleteConfirmation(BuildContext context, String userName, UserProvider userProvider, S s) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(s.deleteUser),
          content: Text(s.deleteUserConfirmation(userName)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(s.cancel),
            ),
            TextButton(
              onPressed: () {
                userProvider.deleteUser(userName);
                Navigator.of(context).pop();
              },
              child: Text(s.delete),
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
