import 'package:flutter/material.dart';
import 'Settings.dart';
import 'generated/l10n.dart';
import 'HomePage.dart';

class StartingPage extends StatefulWidget {
  @override
  _StartingPageState createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage> {
  final TextEditingController _controller = TextEditingController();
  bool isColorBlind = false;

  void goToHomePage() {
    String userName = _controller.text;

    // Navigate to HomePage, passing the userName and color blindness info
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          userName: userName,
          isColorBlind: isColorBlind,
          userId: 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome!',
        style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter your name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: isColorBlind,
                  onChanged: (bool? value) {
                    setState(() {
                      isColorBlind = value ?? false;
                    });
                  },
                ),
                const Text('Do you have color blindness?'),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: goToHomePage,
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
