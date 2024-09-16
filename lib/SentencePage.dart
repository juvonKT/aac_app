import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';  // For Counter-like functionality

import 'firestore_service.dart';  // Import the Firestore service

class SentencePage extends StatefulWidget {
  final int userId;

  SentencePage({required this.userId});

  @override
  _SentencePageState createState() => _SentencePageState();
}

class _SentencePageState extends State<SentencePage> {
  final FirestoreService _firestoreService = FirestoreService();
  List<String> sentences = [];
  List<MapEntry<String, int>> topStartingWords = [];

  @override
  void initState() {
    super.initState();
    print("Initializing SentencePage for user ${widget.userId}");
    fetchSentenceData();
  }

  Future<void> fetchSentenceData() async {
    try {
      // Step 1: Fetch sentence history
      List<String> sentenceHistory = await _firestoreService.getSentenceHistory(widget.userId);

      // Step 2: Compute word frequency
      Map<String, int> wordFrequency = computeStartingWordFrequency(sentenceHistory);

      // Step 3: Get the top starting words (e.g., top 3)
      setState(() {
        sentences = sentenceHistory;
        topStartingWords = getTopStartingWords(wordFrequency, 3);
      });
    } catch (e) {
      print("Error in fetchSentenceData: $e");
      // Optionally show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch sentence data")),
      );
    }
  }

  Map<String, int> computeStartingWordFrequency(List<String> sentences) {
    final Map<String, int> wordCount = {};
    for (var sentence in sentences) {
      String firstWord = sentence.split(' ').first.toLowerCase();
      if (wordCount.containsKey(firstWord)) {
        wordCount[firstWord] = wordCount[firstWord]! + 1;
      } else {
        wordCount[firstWord] = 1;
      }
    }
    return wordCount;
  }

  List<MapEntry<String, int>> getTopStartingWords(
      Map<String, int> wordCount, int topN) {
    return wordCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value))
      ..take(topN).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sentence History'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sentences:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: sentences.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(sentences[index]),
                  );
                },
              ),
            ),
            Divider(),
            Text(
              'Top Starting Words:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...topStartingWords.map((entry) {
              return ListTile(
                title: Text('${entry.key}'),
                subtitle: Text('Used ${entry.value} times'),
              );
            }).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _firestoreService.addSentence(widget.userId, "New sentence to test");
          fetchSentenceData();  // Refresh the data
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
