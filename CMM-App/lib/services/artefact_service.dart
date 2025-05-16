import 'dart:io';
import 'package:cheshire_military_museum_tour/services/artefact_api_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:convert';

import '../models/artefact.dart';


class ArtefactService {
  ArtefactApiService apiService = ArtefactApiService(baseUrl: 'https://2326780.win.studentwebserver.co.uk/cmm/api');

  Future<File> _getArtefactFile(String artifactId) async {
    final baseDir = (await getApplicationDocumentsDirectory()).path;
    final dirPath = p.join(baseDir, 'data', 'artifacts', 'json');

    final directory = Directory(dirPath);
    // Ensure directory exists
    await directory.create(recursive: true);

    return File('$dirPath/$artifactId.json');
  }

  Future<String> saveArtefactJson(String artifactId, String jsonContent) async {
    final file = await _getArtefactFile(artifactId);
    // print('Save path is -------------> ${file.path}');
    await file.writeAsString(jsonContent);
    return file.path;
  }

  Future<String?> readArtefactJson(String artifactId) async {
    final file = await _getArtefactFile(artifactId);
    if (await file.exists()) {
      return await file.readAsString();
    }
    return null;
  }

  Future<bool> artefactExists(String artifactId) async {
    final file = await _getArtefactFile(artifactId);
    return file.exists();
  }

  Artefact parseArtefactFromJson(String jsonContent) {
    final data = json.decode(jsonContent);

    return Artefact(
      id: data['artifactId'],
      name: data['name'],
      description: data['description'],
    );
  }

  Future<Artefact?> getArtefactById(String id) async {
    var json =  await apiService.fetchArtifactJson(id);

    if (json == null || json.isEmpty) {
      return null;
    }

    return parseArtefactFromJson(json);
  }
}