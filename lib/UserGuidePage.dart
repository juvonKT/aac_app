import 'package:flutter/material.dart';
import 'generated/l10n.dart';

class UserGuidePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const BackButton(
          color: Colors.white,
        ),
        title: Text(
          s.userGuide,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle(s.purposeTitle),
          _buildSectionContent(s.purposeContent),

          _buildSectionTitle(s.addUserTitle),
          _buildSectionContent(s.addUserContent),

          _buildSectionTitle(s.deleteUserTitle),
          _buildSectionContent(s.deleteUserContent),

          _buildSectionTitle(s.changeLanguageTitle),
          _buildSectionContent(s.changeLanguageContent),

          _buildSectionTitle(s.changeThemeTitle),
          _buildSectionContent(s.changeThemeContent),

          _buildSectionTitle(s.usePhrasesTitle),
          _buildSectionContent(s.usePhrasesContent),

          _buildSectionTitle(s.addPhraseTitle),
          _buildSectionContent(s.addPhraseContent),

          _buildSectionTitle(s.useTTSTitle),
          _buildSectionContent(s.useTTSContent),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        content,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
