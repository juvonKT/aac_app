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
import 'api_service.dart';
import 'firestore_service.dart';
import 'user_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  int userId;
  HomePage({Key? key, required String userName, required bool isColorBlind, required this.userId}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FlutterTts flutterTts = FlutterTts();
  Map<String, Map<String, dynamic>> phrases = {};
  List<String> selectedPhrases = [];
  String? selectedCategory;
  List<MapEntry<String, int>> topStartingWords = [];
  List<String> suggestedWords = [];
  final FirestoreService _firestoreService = FirestoreService();
  final ApiService apiService = ApiService();
  bool showStartingWords = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadPhrases().then((data) {
      setState(() {
        phrases = data;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchTopStartingWords();
  }

  Future<void> fetchTopStartingWords() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      List<MapEntry<String, int>> words = await _firestoreService.getTopStartingWords(userProvider.selectedUserId, 5);
      setState(() {
        topStartingWords = words;
      });
    } catch (e) {
      print('Error fetching top starting words: $e');
    }
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

  Future<void> updateSuggestedWords() async {
    try {
      List<String> newSuggestions = await apiService.getSuggestions(selectedPhrases);
      setState(() {
        suggestedWords = newSuggestions;
      });
      print("suggested: $suggestedWords");
    } catch (e) {
      print('Error getting suggestions: $e');
      // Optionally show an error message to the user
    }
  }

  void addPhrase(String phrase) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (showStartingWords) {
      try {
        await _firestoreService.addPhraseForUser(userProvider.selectedUserId, phrase);
      } catch (e) {
        // Handle errors here (e.g., show a toast or log the error)
        print('Error adding phrase to Firestore: $e');
      }
    }

    if (mounted) {  // Ensure the widget is still in the tree
      setState(() {
        selectedPhrases.add(phrase);
        showStartingWords = false;  // Hide starting words after adding any phrase
      });
      updateSuggestedWords();
    }
  }


  void removePhrase(String localizedMessage) {
    setState(() {
      if (selectedPhrases.isNotEmpty) {
        selectedPhrases.removeLast();
      }
      showStartingWords = selectedPhrases.isEmpty;  // Show starting words if all phrases are removed
    });
    updateSuggestedWords();
    Fluttertoast.showToast(
      msg: localizedMessage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void clearPhrases() {
    setState(() {
      selectedPhrases.clear();
      showStartingWords = true;  // Show starting words when phrases are cleared
    });
    updateSuggestedWords();
  }

  void _speak() async {
    Locale locale = Localizations.localeOf(context);
    String languageCode = locale.languageCode;

    // Set the language for flutter_tts
    await flutterTts.setLanguage(languageCode);
    await flutterTts.speak(selectedPhrases.join(' '));
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  void goToCategory(String category) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
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
          userId: userProvider.selectedUserId,
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

  Color getColorFromIndex(int index) {
    final colors = [
      const Color(0xFFF36856),
      const Color(0xFFc84adc),
      const Color(0xFFf0e408),
      const Color(0xFFf39f19),
      const Color(0xFF46f88d),
      const Color(0xFF49fedc),
      const Color(0xFFfcff58),
      const Color(0xFF8777ad),
      const Color(0xFF748e49),
      const Color(0xFFdb6e40),
      const Color(0xFFdb778b),
      const Color(0xFF28d297)
    ];
    // Generate a color by cycling through the color list
    return colors[index % colors.length].withOpacity(0.7 + (0.3 * (index % 2)));
  }
  // can remove later
  Future<void> testConnection() async {
    try {
      String result = await apiService.testConnection();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    } catch (e) {
      print('Test connection error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Connection test failed: $e')),
      );
    }
  }

  Widget _buildWordButton(String word, bool isStartingWord) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: isStartingWord ? Colors.blue[200] : Colors.purple[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: () => addPhrase(word),
        child: Text(word),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    // final userProvider = Provider.of<UserProvider>(context);

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
          IconButton(
            icon: Icon(Icons.network_check),
            onPressed: testConnection,
          ),
        ],
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
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
                            "categoryImage": "assets/images/test.png",
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
            Container(
              height: 1.0,
              color: Theme.of(context).appBarTheme.foregroundColor,
              width: double.infinity,
            ),
            Expanded(
              child: Column(
                children: [
                  // Word suggestions section (starting words + next words)
                  SizedBox(
                    height: 100, // Adjust as needed
                    child: topStartingWords.isEmpty && showStartingWords
                        ? const Center(child: CircularProgressIndicator())// Show a loading spinner until words are fetched
                        : ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        if (showStartingWords)
                          ...topStartingWords.map((entry) => _buildWordButton(entry.key, true))
                        else
                          ...suggestedWords.map((word) => _buildWordButton(word, false)),
                      ],
                    ),
                  ),
                  Container(
                    height: 1.0,
                    color: Theme.of(context).appBarTheme.foregroundColor,
                    width: double.infinity,
                  ),
                  // Category grid
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
                        Color categoryColor = getColorFromIndex(index);

                        return GestureDetector(
                          onTap: () {
                            goToCategory(category);
                          },
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                final s = S.of(context);
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
                                  : categoryColor,
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
                                    color: Colors.black,
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