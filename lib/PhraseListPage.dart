import 'package:flutter/material.dart';
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
  });

  @override
  _PhraseListPageState createState() => _PhraseListPageState();
}

class _PhraseListPageState extends State<PhraseListPage> {
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
                      color: Colors.deepPurple,
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
