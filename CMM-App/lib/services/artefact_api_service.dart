import 'dart:io';

import 'package:http/http.dart' as http;

class ArtefactApiService {
  final String baseUrl;

  ArtefactApiService({required this.baseUrl});

  /// Fetches the JSON data for an artifact with the given [artefactId].
  ///
  /// Returns the raw JSON string if the request is successful, or `null` if
  /// the request fails or an error occurs.
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

  /// Fetches the image for an artifact with the given [artefactId].
  ///
  /// Returns the [http.Response] containing the image data if the request
  /// is successful, or `null` if the request fails or an error occurs.
  Future<http.Response?> fetchArtifactImage(String artefactId) async {
    final url = Uri.parse('$baseUrl/artifact/img/$artefactId');

    try {
      final response = await http.get(url);
      if (response.statusCode == HttpStatus.ok) {
        return response;
      } else {
        print('Failed to load artifact image: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching artifact image: $e');
      return null;
    }
  }
}