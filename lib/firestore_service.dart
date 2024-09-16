import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<String>> getSentenceHistory(int userId) async {
    try {
      print("Attempting to fetch sentence history for user $userId");
      QuerySnapshot snapshot = await _db
          .collection('users')
          .doc('user$userId')
          .collection('sentences')
          .orderBy('sentence_id')
          .get();
      print("Successfully fetched ${snapshot.docs.length} sentences");
      List<String> sentences = snapshot.docs.map((doc) => doc['sentence_content'] as String).toList();
      return sentences;
    } catch (e) {
      print("Error fetching sentence history: $e");
      return [];
    }
  }

  Future<void> addSentence(int userId, String sentenceContent) async {
    try {
      await _db.collection('users').doc(userId.toString()).collection('sentences').add({
        'sentence_content': sentenceContent,
        'sentence_id': FieldValue.serverTimestamp(),
      });
      print("Sentence added successfully");
    } catch (e) {
      print("Error adding sentence: $e");
    }
  }

  Future<List<MapEntry<String, int>>> getTopStartingWords(int userId, int limit) async {
    try {
      List<String> sentences = await getSentenceHistory(userId);
      Map<String, int> wordCount = {};
      for (String sentence in sentences) {
        String firstWord = sentence.split(' ').first.toLowerCase();
        wordCount[firstWord] = (wordCount[firstWord] ?? 0) + 1;
      }
      List<MapEntry<String, int>> sortedWords = wordCount.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      return sortedWords.take(limit).toList();
    } catch (e) {
      print("Error getting top starting words: $e");
      return [];
    }
  }
}