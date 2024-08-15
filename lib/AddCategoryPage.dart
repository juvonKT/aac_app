// lib/AddPhrasePage.dart
import 'package:flutter/material.dart';
import 'generated/l10n.dart';

class AddCategoryPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Category'),
        backgroundColor: Colors.black,
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration:  InputDecoration(
                labelText: s.newCategory,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String newPhrase = _controller.text;
                if (newPhrase.isNotEmpty) {
                  Navigator.pop(context, newPhrase);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              child: Text(s.addCategory),
            ),
          ],
        ),
      ),
    );
  }
}
