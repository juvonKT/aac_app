import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class CommunicationBoard extends StatefulWidget {
  const CommunicationBoard({super.key});

  @override
  _CommunicationBoardState createState() => _CommunicationBoardState();
}

class _CommunicationBoardState extends State<CommunicationBoard> {
  final TextEditingController _textController = TextEditingController();
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void dispose() {
    _textController.dispose();
    _flutterTts.stop();
    super.dispose();
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(hintText: 'Field Text'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _textController.clear();
            },
            child: const Icon(Icons.delete),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () async {
              String text = _textController.text;
              if (text.isNotEmpty) {
                await _flutterTts.speak(text);
              }
            },
            child: const Row(
              children: [
                Text('Speak'),
                Icon(Icons.volume_up, size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameBar() {
    return Row(
      children: [
        const BackButton(),
        const Expanded(child: Text('Name of Category', style: TextStyle(fontSize: 16))),
        TextButton(onPressed: () {}, child: const Text('Add word')),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(child: ElevatedButton(onPressed: () {}, child: const Text('Add to field text'))),
        const SizedBox(width: 8),
        Expanded(child: ElevatedButton(onPressed: () {}, child: const Text('Go to category'))),
      ],
    );
  }

  Widget _buildCategoryGrid() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: 12,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(8),
            color: Colors.grey[800],
          );
        },
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            _buildNameBar(),
            _buildActionButtons(),
            _buildCategoryGrid(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }
}