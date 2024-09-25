import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;


  Future<void> addPhraseForUser(String? userId, String phrase) async {
    if (userId == null) return;
    try {
      await _db.collection('users').doc(userId).collection('phrases').add({
        'phrase': phrase,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error adding phrase for user: $e");
    }
  }

  Future<List<String>> getSentenceHistory(String? userId) async {
    if (userId == null) return [];
    try {
      QuerySnapshot snapshot = await _db.collection('users')
          .doc(userId)
          .collection('sentenceHistory')
          .get(GetOptions(source: Source.cache));

      if (snapshot.docs.isEmpty) {
        // If cache is empty, try to fetch from server
        snapshot = await _db.collection('users')
            .doc(userId)
            .collection('sentenceHistory')
            .get(GetOptions(source: Source.server));
      }

      return snapshot.docs.map((doc) => doc['sentence_content'] as String).toList();
    } catch (e) {
      print("Error fetching sentence history: $e");
      return [];
    }
  }


  Future<void> addSentence(String? userId, String sentence) async {
    if (userId == null) return;
    try {
      DocumentReference docRef = _db.collection('users')
          .doc(userId)
          .collection('sentenceHistory')
          .doc(sentence);

      await _db.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(docRef);
        if (!snapshot.exists) {
          transaction.set(docRef, {
            'sentence_content': sentence,
            'usage_count': 1,
          });
        } else {
          int newCount = ((snapshot.data() as Map<String, dynamic>)['usage_count'] as int) + 1;
          transaction.update(docRef, {'usage_count': newCount});
        }
      });
    } catch (e) {
      print("Error adding or incrementing sentence: $e");
    }
  }

  Future<List<MapEntry<String, int>>> getTopStartingWords(String? userId, int limit) async {
    if (userId == null) return [];
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