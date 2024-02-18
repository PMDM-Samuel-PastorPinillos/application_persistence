import 'package:flutter/material.dart';
import 'package:delivery_application/notes_screen.dart';
import 'package:delivery_application/preferences_screen.dart';
import 'package:delivery_application/products_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App persistencia',
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('App Persistencia')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NotesScreen()));
              },
              child: Text('Anotaciones'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PreferencesScreen()));
              },
              child: Text('Preferencias'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsScreen()));
              },
              child: Text('Productos'),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.green,
    );
  }
}


