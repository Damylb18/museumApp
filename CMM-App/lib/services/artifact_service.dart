import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;


class ArtifactService {

  Future<File> _getArtifactFile(String artifactId) async {
    final baseDir = (await getApplicationDocumentsDirectory()).path;
    final dirPath = p.join(baseDir, 'data', 'artifacts', 'json');

    final directory = Directory(dirPath);
    // Ensure directory exists
    await directory.create(recursive: true);

    return File('$dirPath/$artifactId.json');
  }

  Future<String> saveArtifactJson(String artifactId, String jsonContent) async {
    final file = await _getArtifactFile(artifactId);
    // print('Save path is -------------> ${file.path}');
    await file.writeAsString(jsonContent);
    return file.path;
  }

  Future<String?> readArtifactJson(String artifactId) async {
    final file = await _getArtifactFile(artifactId);
    if (await file.exists()) {
      return await file.readAsString();
    }
    return null;
  }

  Future<bool> artifactExists(String artifactId) async {
    final file = await _getArtifactFile(artifactId);
    return file.exists();
  }
}