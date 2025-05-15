import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;


class ArtefactService {

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
}