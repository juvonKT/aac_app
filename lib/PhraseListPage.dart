import 'package:flutter/material.dart';
import 'settings.dart';
import 'AddPhrasePage.dart';

class PhraseListPage extends StatelessWidget {
  final String category;
  final List<Map<String, String>> phrases;
  final Function(String) onPhraseSelected;
  final VoidCallback onClearPhrases;
  final VoidCallback onRemovePhrase;
  final VoidCallback onSpeak;
  final List<String> selectedPhrases;

  PhraseListPage({
    required this.category,
    required this.phrases,
    required this.onPhraseSelected,
    required this.onClearPhrases,
    required this.onRemovePhrase,
    required this.onSpeak,
    required this.selectedPhrases,
  });

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
            onLongPress: onClearPhrases,
            child: IconButton(
              icon: const Icon(Icons.backspace, color: Colors.white),
              onPressed: onRemovePhrase,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.volume_up, color: Colors.white),
            onPressed: onSpeak,
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
                  category,
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
                      // Add the new phrase to the list of phrases
                      Map<String, String> newPhrase = {
                        "phrase": newPhraseText,
                        "image": "assets/images/test.png"
                      };
                      phrases.add(newPhrase);
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
              itemCount: phrases.length,
              itemBuilder: (context, index) {
                Map<String, String> phrase = phrases[index];
                return GestureDetector(
                  onTap: () {
                    onPhraseSelected(phrase["phrase"]!);
                    Navigator.pop(context);
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
