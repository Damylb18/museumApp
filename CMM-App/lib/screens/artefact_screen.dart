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
    // You will fetch artefact info based on artefactId
    return Scaffold(
      appBar: AppBar(title: Text('Artefact Details')),
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
    );
  }
}