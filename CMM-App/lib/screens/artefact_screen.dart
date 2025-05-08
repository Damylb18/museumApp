import 'package:flutter/material.dart';

class ArtefactDetailScreen extends StatelessWidget {
  final String artefactId;
  final bool isNew;

  const ArtefactDetailScreen({
    required this.artefactId,
    required this.isNew,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFDBD3BD), // light beige
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFDBD3BD),
          foregroundColor: Colors.black,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text('Artefact Details')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Artefact ID: $artefactId'),
              Text(isNew ? 'This is a new scan!' : 'You’ve already scanned this.'),
              // TODO: Load artefact data from a DB, API, or static list
            ],
          ),
        ),
      ),
    );
  }
}