
import 'package:flutter/material.dart';
import '../models/medal_tracker.dart';

class MedalsScreen extends StatelessWidget {
  const MedalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final medals = MedalTracker().earnedMedals;

    return Theme(
      data: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFDBD3BD),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Medals'),
          backgroundColor: const Color(0xFFDBD3BD),
        ),
        body: medals.isEmpty
            ? const Center(child: Text('No medals yet. Scan artefacts to earn them!'))
            : ListView.builder(
          itemCount: medals.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.military_tech, color: Colors.brown),
              title: Text(
                medals[index],
                style: const TextStyle(color: Colors.black),
              ),
            );
          },
        ),
      ),
    );
  }
}