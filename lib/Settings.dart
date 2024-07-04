// lib/settings.dart
import 'package:flutter/material.dart';
import 'UserGuidePage.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String _selectedUser = 'User A';
  String _selectedLanguage = 'English';
  String _selectedColourScheme = 'Light';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Settings',
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
              title: const Text('Language'),
              subtitle: Text(_selectedLanguage),
              trailing: DropdownButton<String>(
                value: _selectedLanguage,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedLanguage = newValue!;
                  });
                },
                items: <String>['English', 'Malay', 'Mandarin', 'Tamil']
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
              title: const Text('Colour Scheme'),
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
              title: const Text('User Guide'),
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
        currentIndex: 1, // This is to highlight the Settings tab
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
