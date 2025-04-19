import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadDocumentScreen extends StatefulWidget {
  const UploadDocumentScreen({Key? key}) : super(key: key);

  @override
  _UploadDocumentScreenState createState() => _UploadDocumentScreenState();
}

class _UploadDocumentScreenState extends State<UploadDocumentScreen> {
  File? _pdfFile;
  String _documentName = '';

  Future<void> _selectPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _pdfFile = File(result.files.single.path!);
      });
    } else {
      
    }
  }

  void _uploadDocument() {
    if (_pdfFile == null || _documentName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a PDF and enter a document name.')),
      );
      return;
    }
    
    // Here you would implement the logic to upload the PDF file
    // For example, using Firebase Storage or another cloud storage service
    
    print('Uploading document: $_documentName');
    print('File path: ${_pdfFile!.path}');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Document uploaded successfully!')),
    );
    setState(() {
      _pdfFile = null;
      _documentName = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Document'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Document Name',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _documentName = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectPdf,
              child: const Text('Select PDF'),
            ),
            const SizedBox(height: 20),
            _pdfFile != null
                ? Text('Selected file: ${_pdfFile!.path}')
                : const Text('No file selected'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadDocument,
              child: const Text('Upload Document'),
            ),
          ],
        ),
      ),
    );
  }
}