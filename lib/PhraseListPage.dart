import 'package:flutter/material.dart';
import 'firestore_service.dart';
import 'settings.dart';
import 'AddPhrasePage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PhraseListPage extends StatefulWidget {
  final String category;
  final List<Map<String, String>> phrases;
  final Function(String) onPhraseSelected;
  final VoidCallback onClearPhrases;
  final VoidCallback onRemovePhrase;
  final VoidCallback onSpeak;
  final List<String> selectedPhrases;
  final VoidCallback savePhrase;
  final String? userId;
  final Function() onLanguageChanged;

  const PhraseListPage({
    super.key,
    required this.category,
    required this.phrases,
    required this.onPhraseSelected,
    required this.onClearPhrases,
    required this.onRemovePhrase,
    required this.onSpeak,
    required this.selectedPhrases,
    required this.savePhrase,
    required this.userId,
    required this.onLanguageChanged
  });

  @override
  _PhraseListPageState createState() => _PhraseListPageState();
}

class _PhraseListPageState extends State<PhraseListPage> {
  List<Map<String, String>> phrasesList = [];
  List<Map<String, String>> normalPhrasesList = [];

  @override
  void initState() {
    super.initState();
    phrasesList = widget.phrases;
    normalPhrasesList = phrasesList;
  }

  void updateAppBar() {
    setState(() {
    });
  }

  void deletePhrase(int index) {
    String deletedPhrase = phrasesList[index]["phrase"]!;
    setState(() {
      phrasesList.removeAt(index);
    });
    widget.savePhrase();

    Fluttertoast.showToast(
      msg: "Phrase '$deletedPhrase' has been deleted",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  LinearGradient getGradientFromIndex(int index, int totalPhrases) {
    // Calculate hue increment based on total phrases to ensure smooth transitions
    final hueIncrement = 360 / totalPhrases; // Distribute hues evenly around the circle
    final hue = (index * hueIncrement) % 360;

    // Colors based on calculated hues, with slight variations for gradient effect
    final color1 = HSVColor.fromAHSV(1, hue.toDouble(), 0.7, 0.8).toColor();
    final color2 = HSVColor.fromAHSV(1, (hue + 20) % 360, 0.8, 0.9).toColor();

    return LinearGradient(
      colors: [color1, color2],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
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

  void _navigateToSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Settings(
          onLanguageChanged: widget.onLanguageChanged,
        ),
      ),
    );
  }

  void _changeToPastTense() {
    if (widget.category == "actions") {
      List<Map<String, String>> updatedPhrases = [];

      for (var phraseMap in phrasesList) {
        String phrase = phraseMap["phrase"]!;

        // Check if the phrase is already in past tense (tracked by a new key)
        if (phraseMap.containsKey("isPastTense") && phraseMap["isPastTense"] == "true") {
          updatedPhrases = normalPhrasesList;
        } else if (phraseMap.containsKey("isProgressiveTense") && phraseMap["isProgressiveTense"] == "true") {
          updatedPhrases = normalPhrasesList;
        } else {
          // Extract the verb (assuming it's the first word of the phrase)
          List<String> words = phrase.split(" ");
          String verb = words[0];

          // Convert the verb to past tense
          String pastTenseVerb = _convertToPastTense(verb);
          words[0] = pastTenseVerb;

          // Reassemble the phrase without adding any suffix
          String updatedPhrase = words.join(" ");
          updatedPhrases.add({
            "phrase": updatedPhrase,
            "image": phraseMap["image"] ?? "assets/images/default.png",
            "isPastTense": "true", // Track that this phrase is in past tense
          });
        }
      }

      // Update phrasesList with the new past tense phrases
      setState(() {
        phrasesList = updatedPhrases;
      });
    }
  }

  String _convertToPastTense(String verb) {
    // Handle irregular verbs
    const irregularVerbs = {
      "arise": "arose",
      "awake": "awoke",
      "be": "was",
      "bear": "bore",
      "beat": "beat",
      "become": "became",
      "begin": "began",
      "bend": "bent",
      // a lot more but lazy to add (add when free)
      "eat": "ate",
      "read": "read",
      "drink": "drank",
      "sleep": "slept",
      "run": "ran",
    };

    // Check if the verb is an irregular verb
    String pastTense;
    if (irregularVerbs.containsKey(verb.toLowerCase())) {
      pastTense = irregularVerbs[verb.toLowerCase()]!;
    } else {
      pastTense = _convertVerbToPastTense(verb);
    }

    // Return the past tense with the first letter capitalized
    return _capitalizeFirstLetter(pastTense);
  }

// Function to convert a single regular verb to past tense using rules
  String _convertVerbToPastTense(String verb) {
    // Rule-based approach for regular verbs
    if (verb.endsWith("e")) {
      return verb + "d"; // e.g., "like" -> "liked"
    } else if (verb.endsWith("y") && verb.length > 1 && !isVowel(verb[verb.length - 2])) {
      return verb.substring(0, verb.length - 1) + "ied"; // e.g., "hurry" -> "hurried"
    } else {
      return verb + "ed"; // e.g., "play" -> "played"
    }
  }

// Function to check if a character is a vowel
  bool isVowel(String char) {
    return "aeiou".contains(char.toLowerCase());
  }

// Helper function to capitalize the first letter of a string
  String _capitalizeFirstLetter(String word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1);
  }

  void _changeToProgressiveTense() {
    if (widget.category == "actions") {
      List<Map<String, String>> updatedPhrases = [];

      for (var phraseMap in phrasesList) {
        String phrase = phraseMap["phrase"]!;

        // Check if the phrase is already in progressive tense (tracked by a new key)
        if (phraseMap.containsKey("isProgressiveTense") && phraseMap["isProgressiveTense"] == "true") {
          updatedPhrases = normalPhrasesList; // Skip if it's already converted
        } else if (phraseMap.containsKey("isPastTense") && phraseMap["isPastTense"] == "true") {
          updatedPhrases = normalPhrasesList; // Skip if it's in past tense
        } else {
          // Extract the verb (assuming it's the first word of the phrase)
          List<String> words = phrase.split(" ");
          String verb = words[0];

          // Convert the verb to progressive tense
          String progressiveVerb = _convertToProgressiveTense(verb);
          words[0] = progressiveVerb;

          // Reassemble the phrase without adding any suffix
          String updatedPhrase = words.join(" ");
          updatedPhrases.add({
            "phrase": updatedPhrase,
            "image": phraseMap["image"] ?? "assets/images/default.png",
            "isProgressiveTense": "true", // Track that this phrase is in progressive tense
          });
        }
      }

      // Update phrasesList with the new progressive tense phrases
      setState(() {
        phrasesList = updatedPhrases;
      });

      // Save the updated phrases
      widget.savePhrase();
    }
  }

// Helper function to convert a verb to the progressive tense
  String _convertToProgressiveTense(String verb) {
    // Handle irregular verbs if necessary
    const irregularVerbs = {
      "run": "running",
    };

    // Check if the verb is irregular (optional)
    if (irregularVerbs.containsKey(verb.toLowerCase())) {
      return irregularVerbs[verb.toLowerCase()]!;
    }

    // Apply rules to convert regular verbs to the progressive tense
    if (verb.endsWith("e") && verb != "be") {
      return verb.substring(0, verb.length - 1) + "ing";
    } else if (verb.endsWith("ie")) {
      return verb.substring(0, verb.length - 2) + "ying";
    } else {
      return verb + "ing";
    }
  }

// Example functions to change tenses (you would implement these properly)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            widget.selectedPhrases.join(' '),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          GestureDetector(
            onLongPress: () {
              widget.onClearPhrases();
              updateAppBar();
            },
            child: IconButton(
              icon: const Icon(Icons.backspace, color: Colors.white),
              onPressed: () {
                widget.onRemovePhrase();
                updateAppBar();
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.volume_up, color: Colors.white),
            onPressed: widget.onSpeak,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  widget.category,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.black),
                  onPressed: () async {
                    final newPhraseText = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddPhrasePage()),
                    );
                    if (newPhraseText != null && newPhraseText is String) {
                      setState(() {
                        phrasesList.add({
                          "phrase": newPhraseText,
                          "image": "assets/images/test.png",
                        });
                      });
                      widget.savePhrase();
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView( // Allowing to scroll
              padding: const EdgeInsets.all(16.0),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Wrap(
                    spacing: 16.0,
                    runSpacing: 16.0,
                    children: List.generate(phrasesList.length, (index) {
                      Map<String, String> phrase = phrasesList[index];
                      return GestureDetector(
                        onTap: () {
                          widget.onPhraseSelected(phrase["phrase"]!);
                          Navigator.pop(context);
                        },
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Delete Phrase'),
                                content: Text('Are you sure you want to delete "${phrase["phrase"]}"?'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Delete'),
                                    onPressed: () {
                                      deletePhrase(index);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            minHeight: 120, // Set the minimum height
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.3 - 16, // Fixed width for each box
                            decoration: BoxDecoration(
                              color: getColorFromIndex(index),
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  phrase["image"]!,
                                  height: 50.0,
                                  width: 50.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    phrase["phrase"]!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.visible, // Text wraps
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ),
        if (widget.category == "actions") ...[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Past Tense Button
                Flexible(
                  child: ElevatedButton(
                    onPressed: () {
                      _changeToPastTense(); // Convert to past tense
                    },
                    child: const Text('Past Tense'),
                  ),
                ),

                // Progressive Tense Button
                Flexible(
                  child: ElevatedButton(
                    onPressed: () {
                      _changeToProgressiveTense(); // Convert to progressive tense
                    },
                    child: const Text(
                      'Progressive Tense',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            _navigateToSettings();
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
