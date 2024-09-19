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
  final int userId;

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
    required this.userId
  });

  @override
  _PhraseListPageState createState() => _PhraseListPageState();
}

class _PhraseListPageState extends State<PhraseListPage> {
  final FirestoreService _firestoreService = FirestoreService();
  List<Map<String, String>> phrasesList = [];

  @override
  void initState() {
    super.initState();
    phrasesList = widget.phrases;
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
            onLongPress: widget.onClearPhrases,
            child: IconButton(
              icon: const Icon(Icons.backspace, color: Colors.white),
              onPressed: widget.onRemovePhrase,
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
                      MaterialPageRoute(
                          builder: (context) => AddPhrasePage()),
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
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: phrasesList.length,
              itemBuilder: (context, index) {
                Map<String, String> phrase = phrasesList[index];
                return GestureDetector(
                  onTap: () {
                    _firestoreService.addSentence(widget.userId, phrase["phrase"]!);
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
                  child: Container(
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
                        Text(
                          phrase["phrase"]!,
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
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
