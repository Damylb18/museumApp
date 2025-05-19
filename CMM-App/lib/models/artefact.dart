import 'dart:io';

class Artefact {
  final String id;
  String name;
  String description;
  File? imageFile;

  Artefact({
    required this.id,
    required this.name,
    required this.description,
    this.imageFile,
});

  setImage(File image) {
    imageFile = image;
  }
}