import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'generated/l10n.dart';
import 'providers/user_provider.dart';

class StartingPage extends StatefulWidget {
  final VoidCallback onUserCreated;

  const StartingPage({Key? key, required this.onUserCreated}) : super(key: key);

  @override
  _StartingPageState createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage> {
  final TextEditingController _controller = TextEditingController();

  void _addUser(BuildContext context, String languageCode, String userTheme) async {
    String userName = _controller.text;
    if (userName.isNotEmpty) {
      String userId = FirebaseFirestore.instance.collection('users').doc().id;
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'userId': userId,
        'userName': userName,
      });

      Provider.of<UserProvider>(context, listen: false).addUser(userId, userName, languageCode, userTheme);
      widget.onUserCreated(); // Call the callback when a new user is created
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(s.welcome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: s.enterYourName),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _addUser(context, 'en', 'ThemeMode.light'),
              child: Text(s.addUserButton),
            ),
          ],
        ),
      ),
    );
  }
}