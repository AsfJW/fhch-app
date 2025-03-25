import 'package:flutter/material.dart';
import 'package:friends_hch/components/pdf_viewer.dart';

class DocumentsScreen extends StatelessWidget {
  final List<String> documents = [
    'assets/documents/document1.pdf',
    'assets/documents/document2.pdf',
    // Add more document paths here
  ];

  DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Documents'),
      ),
      body: ListView.builder(
        itemCount: documents.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Document ${index + 1}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PDFViewerPage(documentPath: documents[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
