import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddNewsScreen extends StatefulWidget {
  @override
  _AddNewsScreenState createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends State<AddNewsScreen> {
  final TextEditingController _newsController = TextEditingController();

  Future<void> _addNews() async {
    if (_newsController.text.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('news').add({
          'content': _newsController.text,
          'createdAt': FieldValue.serverTimestamp(),
        });
        _newsController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('News added successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add news')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add News'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _newsController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Enter news content',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addNews,
              child: Text('Add News'),
            ),
          ],
        ),
      ),
    );
  }
}