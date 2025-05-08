

class MedalTracker {
  static final MedalTracker _instance = MedalTracker._internal();

  factory MedalTracker() {
    return _instance;
  }

  MedalTracker._internal();

  final Set<String> scannedArtefacts = {}; // to prevent double-counting
  int get scannedCount => scannedArtefacts.length;

  bool addScan(String artefactId) {
    if (scannedArtefacts.contains(artefactId)) return false;
    scannedArtefacts.add(artefactId);
    return true;
  }

  List<String> get earnedMedals {
    List<String> medals = [];
    if (scannedCount >= 3) medals.add("Bronze Explorer");
    if (scannedCount >= 7) medals.add("Silver Historian");
    if (scannedCount >= 12) medals.add("Gold Curator");
    return medals;
  }
}