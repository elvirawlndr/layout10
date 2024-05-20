import 'package:flutter/material.dart';

class Tutorial11_2Page extends StatefulWidget {
  const Tutorial11_2Page({super.key});

  @override
  _Tutorial11_2PageState createState() => _Tutorial11_2PageState();
}

class _Tutorial11_2PageState extends State<Tutorial11_2Page> {
  final List<String> _items = [];

  void _addItem(String item) {
    setState(() {
      _items.add(item);
    });
  }

  void _showAddItemDialog() {
    final TextEditingController textFieldController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add a new item'),
          content: TextField(
            controller: textFieldController,
            decoration: const InputDecoration(hintText: "Enter item"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _addItem(textFieldController.text);
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutorial 11-2'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_items[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _showAddItemDialog,
              child: const Text('Add Item'),
            ),
          ),
        ],
      ),
    );
  }
}
