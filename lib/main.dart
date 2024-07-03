import 'package:flutter/material.dart';

import 'CommunicationBoard.dart';
import 'HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // primaryColor: const Color(0xFF4A4063),
        // scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        primarySwatch: Colors.deepPurple,
      ),
      // home: const CommunicationBoard(),
      home: const HomePage(),


    );
  }
}

