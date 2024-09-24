class User {
  String userId;
  String userName;
  Map<String, int> phraseHistory; // Keeps track of phrases and their usage frequency.

  User({
    required this.userId,
    required this.userName,
    Map<String, int>? phraseHistory,
  }) : phraseHistory = phraseHistory ?? {};
}
