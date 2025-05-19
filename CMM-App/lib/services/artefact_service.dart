import 'dart:io';
import 'package:cheshire_military_museum_tour/services/artefact_api_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:convert';

import '../models/artefact.dart';

class ArtefactService {
  ArtefactApiService apiService = ArtefactApiService(baseUrl: 'https://2326780.win.studentwebserver.co.uk/cmm/api');

  /// Retrieves an [Artefact] by its ID.
  ///
  /// If the artefact is not already saved locally, it attempts to fetch
  /// it from the API and saves it for future use.
  Future<Artefact?> getArtefactById(String artefactId) async {
    String? json;
    if (!await artefactExists(artefactId)) {
      json = await apiService.fetchArtifactJson(artefactId);
      if (json == null || json.isEmpty) return null;
      await _saveArtefactJson(artefactId, json);
    } else {
      json = await _getArtefactJsonFromFile(artefactId);
      if (json == null || json.isEmpty) return null;
    }

    var artefact = _parseArtefactFromJson(json);
    artefact.setImage(await _getArtefactImageFile(artefactId));

    return artefact;
  }

  /// Returns the image file associated with the given artefact ID.
  ///
  /// If the image is not cached locally, it downloads it from the API
  /// and stores it in the cache directory.
  Future<File?> getArtefactImage(String artefactId) async {
    final file = await _getArtefactImageFile(artefactId);
    if (await file.exists()) {
      return file;
    } else {
      final path = await _downloadAndSaveArtefactImage(artefactId);
      if (path != null) return File(path);
    }
    return null;
  }

  /// Loads all artefacts that have been previously saved as JSON files locally.
  ///
  /// Only returns artefacts that already exist on the device; no network calls are made.
  Future<List<Artefact>> getAllSavedArtefacts() async {
    Directory directory = await _getArtefactJsonDirPath();

    if (!await directory.exists()) {
      return [];
    }

    final files = directory.listSync().where((f) => f is File && f.path.endsWith('.json')).cast<File>();

    List<Artefact> artefacts = [];

    for (final file in files) {
      try {
        final content = await file.readAsString();
        final artefact = _parseArtefactFromJson(content);
        artefacts.add(artefact);
      } catch (e) {
        // Optionally log or handle corrupt file
        print('Failed to parse artefact file ${file.path}: $e');
      }
    }
    return artefacts;
  }

  /// Checks if an artefact has been collected already.
  ///
  /// Looks in file for existing json file.
  Future<bool> artefactExists(String artefactId) async {
    final file = await _getArtefactFile(artefactId);
    return file.exists();
  }

  Future<File> _getArtefactFile(String artefactId) async {
    Directory directory = await _getArtefactJsonDirPath();
    await directory.create(recursive: true);

    var artefactPath = p.join(directory.path, '$artefactId.json');
    return File(artefactPath);
  }

  Future<File> _getArtefactImageFile(String artefactId) async {
    final baseDir = (await getApplicationCacheDirectory()).path;
    final dirPath = p.join(baseDir, 'artefact', 'img');
    final directory = Directory(dirPath);
    await directory.create(recursive: true);
    return File(p.join(dirPath, artefactId));
  }

  Future<String> _saveArtefactJson(String artefactId, String jsonContent) async {
    final file = await _getArtefactFile(artefactId);
    await file.writeAsString(jsonContent);
    return file.path;
  }

  Future<String?> _downloadAndSaveArtefactImage(String artefactId) async {
    final response = await apiService.fetchArtifactImage(artefactId);
    if (response != null) {
      final file = await _getArtefactImageFile(artefactId);
      await file.writeAsBytes(response.bodyBytes);
      return file.path;
    }
    return null;
  }

  Future<String?> _getArtefactJsonFromFile(String artefactId) async {
    final file = await _getArtefactFile(artefactId);
    if (await file.exists()) {
      return await file.readAsString();
    }
    return null;
  }

  Artefact _parseArtefactFromJson(String jsonContent) {
    final data = json.decode(jsonContent);

    // API current returns 'artifact' spelling. Leave this spelling as is unless changed.
    return Artefact(id: data['artifactId'], name: data['name'], description: data['description']);
  }

  Future<Directory> _getArtefactJsonDirPath() async {
    final baseDir = (await getApplicationDocumentsDirectory()).path;
    final dirPath = p.join(baseDir, 'data', 'artefact', 'json');
    final directory = Directory(dirPath);
    return directory;
  }
}
