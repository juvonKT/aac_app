import 'package:flutter/material.dart';

class CommunicationBoard extends StatelessWidget {
  const CommunicationBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildTopBar(),
          _buildNameBar(),
          _buildActionButtons(),
          _buildCategoryGrid(),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        const Expanded(child: TextField(decoration: InputDecoration(hintText: 'Field Text', contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0)))),
        ElevatedButton(onPressed: () {}, child: const Text('Delete')),
        ElevatedButton(onPressed: () {}, child: const Text('Speak')),
      ],
    );
  }

  Widget _buildNameBar() {
    return Row(
      children: [
        const BackButton(),
        const Expanded(child: Text('Name of Category')),
        TextButton(onPressed: () {}, child: const Text('Add word')),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(child: ElevatedButton(onPressed: () {}, child: const Text('Add to field text'))),
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
}