import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;


  Future<void> addPhraseForUser(int userId, String phrase) async {
    // Specify the document path for the user and their phrases
    DocumentReference userRef = _db.collection('users').doc(userId.toString());

    // Add the phrase to the user's phrases collection
    await userRef.collection('phrases').add({
      'phrase': phrase,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<List<String>> getSentenceHistory(String? userId) async {
    try {
      print("Attempting to fetch sentence history for user $userId");
      QuerySnapshot snapshot = await _db.collection('users')
          .doc(userId.toString())
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


  Future<void> addSentence(String? userId, String sentence) async {
    try {
      DocumentReference docRef = _db.collection('users')
          .doc(userId.toString())
          .collection('sentenceHistory')
          .doc(sentence);  // Use sentence as document ID

      await _db.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(docRef);
        if (!snapshot.exists) {
          await transaction.set(docRef, {
            'sentence_content': sentence,
            'usage_count': 1,
          });
        } else {
          int newCount = (snapshot['usage_count'] as int) + 1;
          await transaction.update(docRef, {'usage_count': newCount});
        }
      });
    } catch (e) {
      print("Error adding or incrementing sentence: $e");
    }
  }




  Future<List<MapEntry<String, int>>> getTopStartingWords(String? userId, int limit) async {
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