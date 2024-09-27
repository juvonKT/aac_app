import 'dart:convert';
import 'package:aac_app/providers/language_provider.dart';
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
import 'providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  String? userId;
  HomePage({
    Key? key,
    required String userName,
    required bool isColorBlind,
    required this.userId
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver{
  FlutterTts flutterTts = FlutterTts();
  Map<String, Map<String, dynamic>> phrases = {};
  List<String> selectedPhrases = [];
  String? selectedCategory;
  List<MapEntry<String, int>> topStartingWords = [];
  List<String> suggestedWords = [];
  final FirestoreService _firestoreService = FirestoreService();
  final ApiService apiService = ApiService();
  bool showStartingWords = true;
  bool _isOffline = false;
  bool _isLoadingWords = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    languageProvider.loadUserLanguage(context);

    loadPhrases().then((data) {
      setState(() {
        phrases = data;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.userId != null) {
        fetchTopStartingWords();
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    flutterTts.stop();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      fetchTopStartingWords();
    }
  }

  Future<void> fetchTopStartingWords() async {
    setState(() {
      _isLoadingWords = true;
    });
    try {
      Locale locale = Localizations.localeOf(context);
      String languageCode = locale.languageCode;
      List<MapEntry<String, int>> words = await _firestoreService.getTopStartingWords(widget.userId, languageCode, 7);
      setState(() {
        topStartingWords = words;
        _isLoadingWords = false;
        showStartingWords = true;
      });
    } catch (e) {
      print('Error fetching top starting words: $e');
      setState(() {
        _isLoadingWords = false;
      });
    }
  }

  Future<void> refreshWordsAndClearPhrases() async {
    // Clear phrases immediately
    clearPhrases();

    // Introduce a slight delay to allow for language change to process
    await Future.delayed(const Duration(milliseconds: 100));

    // Fetch top words if user is logged in
    if (widget.userId != null) {
      await fetchTopStartingWords();
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
    Locale locale = Localizations.localeOf(context);
    String languageCode = locale.languageCode;
    try {
      List<String> newSuggestions = await apiService.getSuggestions(selectedPhrases, languageCode);
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
    bool tempShowStarting = showStartingWords;
    setState(() {
      selectedPhrases.add(phrase);
      showStartingWords = false;
    });
    updateSuggestedWords();
    if (tempShowStarting) {
      try {
        Locale locale = Localizations.localeOf(context);
        String languageCode = locale.languageCode;
        await _firestoreService.addPhraseForUser(widget.userId, phrase, languageCode);
      } catch (e) {
        print('Error adding phrase to Firestore: $e');
      }
    }

  }


  void removePhrase(String localizedMessage) {
    setState(() {
      if (selectedPhrases.isNotEmpty) {
        selectedPhrases.removeLast();

        // Check if the first phrase was removed
        if (selectedPhrases.isEmpty) {
          fetchTopStartingWords();
          showStartingWords = true;
        }
      }
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
    fetchTopStartingWords();
  }

  void _speak() async {
    Locale locale = Localizations.localeOf(context);
    String languageCode = locale.languageCode;

    // Set the language for flutter_tts
    await flutterTts.setLanguage(languageCode);
    await flutterTts.speak(selectedPhrases.join(' '));
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
          userId: widget.userId,
          onLanguageChanged: refreshWordsAndClearPhrases,
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

  Widget _buildWordSuggestionsSection() {
    if (_isLoadingWords) {
      return const Center(child: CircularProgressIndicator());
    } else if (topStartingWords.isEmpty) {
      return Center(child: Text(_isOffline ? 'Offline. Using cached data.' : 'No starting words available.'));
    } else {
      return ListView(
        scrollDirection: Axis.horizontal,
        children: [
          if (showStartingWords)
            ...topStartingWords.map((entry) => _buildWordButton(entry.key, true))
          else
            ...suggestedWords.map((word) => _buildWordButton(word, false)),
        ],
      );
    }
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
                    child:_buildWordSuggestionsSection(),
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
              MaterialPageRoute(
                builder: (context) =>  Settings(
                    onLanguageChanged: refreshWordsAndClearPhrases
                ),
              ),
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