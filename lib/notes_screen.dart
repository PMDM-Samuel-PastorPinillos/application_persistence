import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  TextEditingController _textController = TextEditingController();
  String _notes = '';

  Future<String> _getLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> _saveToFile() async {
    final path = await _getLocalPath();
    final file = File('$path/notes.txt');
    await file.writeAsString(_textController.text);
  }

  Future<void> _readFromFile() async {
    final path = await _getLocalPath();
    final file = File('$path/notes.txt');
    setState(() {
      _notes = file.readAsStringSync();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Anotaciones')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _textController),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveToFile();
                _readFromFile();
              },
              child: Text('Guardar'),
            ),
            SizedBox(height: 20),
            Text('Notas guardadas:\n$_notes'),
          ],
        ),
      ),
    );
  }
}