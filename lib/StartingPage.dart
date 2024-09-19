import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_provider.dart';

class StartingPage extends StatefulWidget {
  const StartingPage({super.key});

  @override
  _StartingPageState createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage> {
  final TextEditingController _controller = TextEditingController();

  void _addUser(BuildContext context) {
    String userName = _controller.text;
    if (userName.isNotEmpty) {
      Provider.of<UserProvider>(context, listen: false).addUser(userName);
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
