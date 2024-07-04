// lib/user_guide_page.dart
import 'package:flutter/material.dart';

class UserGuidePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'User Guide',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const Center(
        child: Text(
          'User Guide Content Goes Here',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
