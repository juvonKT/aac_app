import 'dart:convert';
import 'package:flutter/material.dart';
import 'settings.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:aac_app/PhraseListPage.dart';
import 'AddCategoryPage.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'generated/l10n.dart';

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadPhrases().then((data) {
      setState(() {
        phrases = data;
      });
    });
  }

  Future<Map<String, Map<String, dynamic>>> loadPhrases() async {
    Locale locale = Localizations.localeOf(context);
    String languageCode = locale.languageCode;

    final String directory = (await getApplicationDocumentsDirectory()).path;
    final String path = '$directory/phrases_$languageCode.json';
    final File file = File(path);

    if (await file.exists()) {
      String jsonString = await file.readAsString();
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
    } else {
      String jsonString = await rootBundle.loadString('assets/phrases_$languageCode.json');
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      await file.writeAsString(jsonString);
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
  }

  Future<void> savePhrases() async {
    Locale locale = Localizations.localeOf(context);
    String languageCode = locale.languageCode;

    final String directory = (await getApplicationDocumentsDirectory()).path;
    final String path = '$directory/phrases_$languageCode.json';
    final File file = File(path);
    await file.writeAsString(json.encode(phrases));
  }

  void addPhrase(String phrase) {
    setState(() {
      selectedPhrases.add(phrase);
    });
  }

  void removePhrase(String localizedMessage) {
    setState(() {
      if (selectedPhrases.isNotEmpty) {
        selectedPhrases.removeLast();
      }
    });
    Fluttertoast.showToast(
      msg: localizedMessage,
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
    final s = S.of(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhraseListPage(
          category: category,
          phrases: phrases[category]!["phrases"],
          onPhraseSelected: addPhrase,
          onClearPhrases: clearPhrases,
          onRemovePhrase: () => removePhrase(s.removeMessage),
          onSpeak: _speak,
          selectedPhrases: selectedPhrases,
          savePhrase: savePhrases,
        ),
      ),
    );
  }

  void deleteCategory(String category) async {
    setState(() {
      phrases.remove(category);
    });
    await savePhrases();

    // Show a toast message to confirm deletion
    Fluttertoast.showToast(
      msg: S.of(context).categoryDeleted(category),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            selectedPhrases.join(' '),
            style: TextStyle(color: Theme.of(context).appBarTheme.foregroundColor),
          ),
        ),
        actions: [
          GestureDetector(
            onLongPress: clearPhrases,
            child: IconButton(
              icon: Icon(Icons.backspace, color: Theme.of(context).iconTheme.color),
              onPressed: () => removePhrase(s.removeMessage),
            ),
          ),
          IconButton(
            icon: Icon(Icons.volume_up, color: Theme.of(context).iconTheme.color),
            onPressed: _speak,
          ),
        ],
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        s.home,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add, color: Theme.of(context).iconTheme.color),
                    onPressed: () async {
                      final newCategoryText = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddCategoryPage()),
                      );
                      if (newCategoryText != null && newCategoryText is String) {
                        setState(() {
                          phrases[newCategoryText] = {
                            "categoryImage": "assets/images/test.png", // Set a default image
                            "phrases": <Map<String, String>>[]
                          };
                        });
                        await savePhrases();
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
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          final s = S.of(context); // Get the localization object
                          return AlertDialog(
                            title: Text(s.deleteCategory),
                            content: Text(s.deleteCategoryConfirmation(category)),
                            actions: <Widget>[
                              TextButton(
                                child: Text(s.cancel),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text(s.delete),
                                onPressed: () {
                                  deleteCategory(category);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
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
                            style: TextStyle(
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
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: s.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: s.setting,
          ),
        ],
        backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
      ),
    );
  }
}
