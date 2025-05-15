import 'package:flutter_test/flutter_test.dart';
import 'package:cheshire_military_museum_tour/services/artifact_api_service.dart';

void main() {
  group('ArtifactApiService (real API)', () {
    late ArtifactApiService apiService;

    setUp(() {
      apiService = ArtifactApiService(baseUrl: 'https://2326780.win.studentwebserver.co.uk/cmm/api');
    });

    test('fetches artifact JSON from live API', () async {
      const artifactId = '9e7bddc3-fe31-43e4-9064-1ed2c6de7d51';

      final result = await apiService.fetchArtifactJson(artifactId);

      expect(result, isNotNull);
      expect(result, contains('"')); // basic check that it's a JSON string
      print('API returned: $result');
    });
  });
}
