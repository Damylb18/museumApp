import 'dart:io';
import 'package:cheshire_military_museum_tour/services/artefact_service.dart';
import 'package:cheshire_military_museum_tour/widgets/app_bar.dart';
import 'package:cheshire_military_museum_tour/widgets/bottom_info_card.dart';
import 'package:flutter/material.dart';
import '../data/messages.dart';
import '../models/artefact.dart';
import '../models/medal_tracker.dart';
import '../utils/responsive_utils.dart';

class ArtefactDetailScreen extends StatelessWidget {
  final String artefactId;
  final bool isNew;
  final bool fromScanner;

  final resp = ResponsiveUtils.instance;
  final tracker = MedalTracker();
  final ArtefactService artefactService = ArtefactService();

  Future<Artefact?> _loadArtifact() async => artefactService.getArtefactById(artefactId);

  ArtefactDetailScreen({required this.artefactId, required this.isNew, required this.fromScanner, super.key});

  @override
  Widget build(BuildContext context) {
    final scannedCount = tracker.scannedCount;

    // Select a milestone message based on progress
    String? milestoneMessage;

    if (isNew) {
      if (milestoneMessages.containsKey(scannedCount)) {
        milestoneMessage = milestoneMessages[scannedCount];
      } else {
        milestoneMessage = milestoneMessages[0];
      }
    }

    return Scaffold(
      appBar: CustomAppBar(titleText: 'Artefact', context: context),
      body: SafeArea(
        bottom: Platform.isIOS ? false : true,
        child: FutureBuilder<Artefact?>(
          future: _loadArtifact(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error loading artefact: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('Artefact not found.'));
            }

            final artefact = snapshot.data;

            return Column(
              children: [
                // Image
                Padding(
                  padding: EdgeInsets.only(left: 50, right: 50, top: 20),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      height: 150,
                      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8))),
                      child:
                          artefact?.imageFile != null
                              ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(artefact!.imageFile!, fit: BoxFit.cover),
                              )
                              : const Center(child: Icon(Icons.image, color: Colors.grey, size: 200)),
                    ),
                  ),
                ),

                const Spacer(),

                // Bottom info card
                Expanded(
                  flex: 4,
                  child: BottomInfoCard(
                    title: artefact?.name,
                    content: artefact?.description,
                    warning: !isNew && fromScanner ? '⚠️ You\'ve already scanned this artefact.' : null,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
