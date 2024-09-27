import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getPhraseHistory(String? userId, String languageCode) async {
    if (userId == null) return [];

    try {
      // Try to get data from the server
      QuerySnapshot serverSnapshot = await _db.collection('users')
          .doc(userId)
          .collection('phraseHistory')
          .doc(languageCode)
          .collection('phrases')
          .get(GetOptions(source: Source.server));

      return serverSnapshot.docs.map((doc) => {
        'phrase': doc['phrase'] as String,
        'usage_count': doc['usage_count'] as int,
      }).toList();
    } catch (e) {
      print("Error fetching from server: $e");

      // If there's an error (likely due to no internet), fall back to cache
      try {
        QuerySnapshot cacheSnapshot = await _db.collection('users')
            .doc(userId)
            .collection('phraseHistory')
            .doc(languageCode)
            .collection('phrases')
            .get(GetOptions(source: Source.cache));

        return cacheSnapshot.docs.map((doc) => {
          'phrase': doc['phrase'] as String,
          'usage_count': doc['usage_count'] as int,
        }).toList();
      } catch (cacheError) {
        print("Error fetching from cache: $cacheError");
        return [];
      }
    }
  }

  Future<void> addPhraseForUser(String? userId, String phrase, String languageCode) async {
    if (userId == null) return;
    try {
      DocumentReference docRef = _db.collection('users')
          .doc(userId)
          .collection('phraseHistory')
          .doc(languageCode)
          .collection('phrases')
          .doc(phrase);

      await _db.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(docRef);
        if (!snapshot.exists) {
          transaction.set(docRef, {
            'phrase': phrase,
            'usage_count': 1,
          });
        } else {
          int newCount = ((snapshot.data() as Map<String, dynamic>)['usage_count'] as int) + 1;
          transaction.update(docRef, {'usage_count': newCount});
        }
      });
    } catch (e) {
      print("Error adding or incrementing phrase: $e");
    }
  }

  Future<List<MapEntry<String, int>>> getTopStartingWords(String? userId, String languageCode, int limit) async {
    if (userId == null) return [];
    try {
      List<Map<String, dynamic>> phrases = await getPhraseHistory(userId, languageCode);
      Map<String, int> wordCount = {};
      for (var phrase in phrases) {
        String firstWord = phrase['phrase'];
        int count = phrase['usage_count'];
        wordCount[firstWord] = (wordCount[firstWord] ?? 0) + count;
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