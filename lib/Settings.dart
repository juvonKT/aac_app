import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'UserGuidePage.dart';
import 'generated/l10n.dart';
import 'providers/language_provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String _selectedUser = 'User A';
  String _selectedColourScheme = 'Light';

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final s = S.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          s.setting,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: DropdownButton<String>(
                value: _selectedUser,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedUser = newValue!;
                  });
                },
                items: <String>['User A', 'User B', 'User C']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                underline: const SizedBox(),
                isExpanded: true,
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
                items: [
                  DropdownMenuItem(value: Locale('en', ''), child: Text('English')),
                  DropdownMenuItem(value: Locale('ms', ''), child: Text('Malay')),
                  DropdownMenuItem(value: Locale('zh', ''), child: Text('Mandarin')),
                  DropdownMenuItem(value: Locale('ta', ''), child: Text('Tamil')),
                ],
                underline: const SizedBox(),
              ),
            ),
            const Divider(),
            ListTile(
              title: Text(s.colourScheme),
              subtitle: Text(_selectedColourScheme),
              trailing: DropdownButton<String>(
                value: _selectedColourScheme,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedColourScheme = newValue!;
                  });
                },
                items: <String>['Light', 'Dark', 'Colour Palette Generator']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
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
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label:'Settings',
          ),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
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
      case 'ta':
        return 'Tamil';
      default:
        return 'Unknown';
    }
  }
}