import 'dart:convert';
import 'package:flutter/material.dart';
import 'settings.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:aac_app/PhraseListPage.dart';
import 'AddCategoryPage.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FlutterTts flutterTts = FlutterTts();
  Map<String, Map<String, dynamic>> phrases = {};
  List<String> selectedPhrases = [];
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    loadPhrases().then((data) {
      setState(() {
        phrases = data;
      });
    });
  }

  Future<Map<String, Map<String, dynamic>>> loadPhrases() async {
    String jsonString = await rootBundle.loadString('assets/phrases.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    return jsonMap.map((key, value) {
      List<dynamic> phrasesList = value["phrases"];
      List<Map<String, String>> phrasesTyped = phrasesList.map((item) {
        return {
          "phrase": item["phrase"] as String,
          "image": item["image"] as String,
        };
      }).toList();
      return MapEntry(key, {
        "categoryImage": value["categoryImage"] as String,
        "phrases": phrasesTyped,
      });
    });
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

  void goToCategory(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhraseListPage(
          category: category,
          phrases: phrases[category]!["phrases"],
          onPhraseSelected: addPhrase,
          onClearPhrases: clearPhrases,
          onRemovePhrase: removePhrase,
          onSpeak: _speak,
          selectedPhrases: selectedPhrases,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            selectedPhrases.join(' '),
            style: const TextStyle(color: Colors.white),
          ),
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Home",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.black),
                    onPressed: () async {
                      final newCategoryText = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddCategoryPage()),
                      );
                      if (newCategoryText != null && newCategoryText is String) {
                        phrases[newCategoryText] = {
                          "categoryImage": "assets/images/test.png", // Set a default image
                          "phrases": <Map<String, String>>[]
                        };
                        (context as Element).markNeedsBuild();
                      }
                    },
                  ),
                ],
              ),
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
                  String categoryImage = phrases[category]!["categoryImage"];
                  return GestureDetector(
                    onTap: () {
                      goToCategory(category);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedCategory == category
                            ? Colors.deepPurple
                            : Colors.deepPurple[300],
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            categoryImage,
                            height: 50.0,
                            width: 50.0,
                          ),
                          Text(
                            category,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
