// lib/home_page.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'settings.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart' show rootBundle;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FlutterTts flutterTts = FlutterTts();
  Map<String, List<String>> phrases = {};
  List<String> selectedPhrases = [];

  @override
  void initState() {
    super.initState();
    loadPhrases().then((data) {
      setState(() {
        phrases = data;
      });
    });
  }

  Future<Map<String, List<String>>> loadPhrases() async {
    String jsonString = await rootBundle.loadString('assets/phrases.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    return jsonMap.map((key, value) => MapEntry(key, List<String>.from(value)));
  }

  void addPhrase(String phrase) {
    setState(() {
      selectedPhrases.add(phrase);
    });
  }

  void removePhrase() {
    setState(() {
      if (selectedPhrases.isNotEmpty) {
        selectedPhrases.removeLast();
      }
    });
    Fluttertoast.showToast(
      msg: "Hold to remove all",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void clearPhrases() {
    setState(() {
      selectedPhrases.clear();
    });
  }

  void _speak() async {
    await flutterTts.speak(selectedPhrases.join(' '));
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          selectedPhrases.join(' '),
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          GestureDetector(
            onLongPress: clearPhrases,
            child: IconButton(
              icon: const Icon(Icons.backspace, color: Colors.white),
              onPressed: removePhrase,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.volume_up, color: Colors.white),
            onPressed: _speak,
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'Home',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('ADD TO TEXT'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('GO TO CATEGORY'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: phrases.keys.length,
                itemBuilder: (context, index) {
                  String category = phrases.keys.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhraseListPage(
                            category: category,
                            phrases: phrases[category]!,
                            onPhraseSelected: addPhrase,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[300],
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Center(
                        child: Text(
                          category,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // This is to highlight the Home tab
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Settings()),
            );
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

class PhraseListPage extends StatelessWidget {
  final String category;
  final List<String> phrases;
  final Function(String) onPhraseSelected;

  PhraseListPage({
    required this.category,
    required this.phrases,
    required this.onPhraseSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          category,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: phrases.length,
        itemBuilder: (context, index) {
          String phrase = phrases[index];
          return GestureDetector(
            onTap: () {
              onPhraseSelected(phrase);
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Center(
                child: Text(
                  phrase,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
