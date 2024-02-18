import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesScreen extends StatefulWidget {
  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  TextEditingController _themeController = TextEditingController();
  TextEditingController _sessionController = TextEditingController();

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', _themeController.text);
    prefs.setBool('session', _sessionController.text.isNotEmpty);
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _themeController.text = prefs.getString('theme') ?? 'default';
      _sessionController.text = (prefs.getBool('session') ?? false).toString();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Preferencias')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _themeController, decoration: InputDecoration(labelText: 'Tema')),
            TextField(controller: _sessionController, decoration: InputDecoration(labelText: 'Sesión iniciada')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _savePreferences();
                _loadPreferences();
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
  //h
}