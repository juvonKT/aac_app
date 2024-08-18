// lib/user_guide_page.dart
import 'package:flutter/material.dart';

import 'generated/l10n.dart';

class UserGuidePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          s.userGuide,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Text(
          s.userGuideContent,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
