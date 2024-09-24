import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'user_provider.dart';

class StartingPage extends StatefulWidget {
  const StartingPage({super.key});

  @override
  _StartingPageState createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage> {
  final TextEditingController _controller = TextEditingController();

  void _addUser(BuildContext context) async {
    String userName = _controller.text;
    if (userName.isNotEmpty) {
      String userId = FirebaseFirestore.instance.collection('users').doc().id; // Generate a new user ID
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'userId': userId,
        'userName': userName,
      }); // Add user to Firestore

      Provider.of<UserProvider>(context, listen: false).addUser(userId, userName);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Enter your name'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _addUser(context),
              child: const Text('Add User'),
            ),
          ],
        ),
      ),
    );
  }
}
