import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getPhraseHistory(String? userId) async {
    if (userId == null) return [];
    try {
      // First, try to get data from the server
      QuerySnapshot serverSnapshot = await _db.collection('users')
          .doc(userId)
          .collection('phraseHistory')
          .get(GetOptions(source: Source.server));

      // If we successfully got data from the server, return it
      if (serverSnapshot.docs.isNotEmpty) {
        return serverSnapshot.docs.map((doc) => {
          'phrase': doc['phrase'] as String,
          'usage_count': doc['usage_count'] as int,
        }).toList();
      }

      // If server request failed (likely due to no internet), fall back to cache
      QuerySnapshot cacheSnapshot = await _db.collection('users')
          .doc(userId)
          .collection('phraseHistory')
          .get(GetOptions(source: Source.cache));

      return cacheSnapshot.docs.map((doc) => {
        'phrase': doc['phrase'] as String,
        'usage_count': doc['usage_count'] as int,
      }).toList();
    } catch (e) {
      print("Error fetching phrase history: $e");
      // In case of any error, return an empty list
      return [];
    }
  }


  Future<void> addPhraseForUser(String? userId, String phrase) async {
    if (userId == null) return;
    try {
      DocumentReference docRef = _db.collection('users')
          .doc(userId)
          .collection('phraseHistory')
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

  Future<List<MapEntry<String, int>>> getTopStartingWords(String? userId, int limit) async {
    if (userId == null) return [];
    try {
      List<Map<String, dynamic>> phrases = await getPhraseHistory(userId);
      Map<String, int> wordCount = {};
      for (var phrase in phrases) {
        String firstWord = phrase['phrase'].split(' ').first.toLowerCase();
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