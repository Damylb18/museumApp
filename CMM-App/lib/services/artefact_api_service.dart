import 'dart:io';

import 'package:http/http.dart' as http;

class ArtefactApiService {
  final String baseUrl;

  ArtefactApiService({required this.baseUrl});

  Future<String?> fetchArtifactJson(String artefactId) async {
    final url = Uri.parse('$baseUrl/artifact/data/$artefactId');
    // print('Final url = $url');

    try {
      final response = await http.get(url);

      if (response.statusCode == HttpStatus.ok) {
        return response.body; // Raw JSON as string
      } else {
        print('Failed to load artifact: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching artifact: $e');
      return null;
    }
  }
}