import '../services/artefact_service.dart';

class MedalTracker {
  static final MedalTracker _instance = MedalTracker._internal();

  factory MedalTracker() {
    return _instance;
  }

  MedalTracker._internal();

  final Set<String> scannedArtefacts = {};
  int get scannedCount => scannedArtefacts.length;

  bool addScan(String artefactId) {
    if (scannedArtefacts.contains(artefactId)) return false;
    scannedArtefacts.add(artefactId);
    return true;
  }

  List<String> get earnedMedals {
    List<String> medals = [];
    if (scannedCount >= 1) medals.add("Private");
    if (scannedCount >= 3) medals.add("Sergeant");
    if (scannedCount >= 5) medals.add("Lieutenant");
    if (scannedCount >= 7) medals.add("Marshal");
    return medals;
  }

  /// Loads all saved artefact IDs on startup and adds them to the tracker.
  Future<void> initialize(ArtefactService artefactService) async {
    final savedArtefacts = await artefactService.getAllSavedArtefacts();
    for (var artefact in savedArtefacts) {
      scannedArtefacts.add(artefact.id);
    }
  }
}