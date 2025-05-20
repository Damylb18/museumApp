import 'dart:io';
import 'package:cheshire_military_museum_tour/services/artefact_service.dart';
import 'package:flutter/material.dart';
import '../models/artefact.dart';
import '../models/medal_tracker.dart';
import '../utils/responsive_utils.dart';
import '../widgets/circle_button.dart';

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
      switch (scannedCount) {
        case 1:
          milestoneMessage =
              '🪖 Welcome, Private! '
              'Your first artefact is logged. Keep going, recruit!';
          break;
        case 2:
          milestoneMessage =
              '📌 Two artefacts secured. '
              'One more and you’ll earn your stripes as a Sergeant!';
          break;
        case 3:
          milestoneMessage =
              '🎖 Promotion unlocked: Sergeant! '
              'Your journey through history intensifies.';
          break;
        case 4:
          milestoneMessage =
              '🗺 Four artefacts collected. '
              'One more and Lieutenant rank is within reach!';
          break;
        case 5:
          milestoneMessage =
              '🎖️ Rank up! You’ve become a Lieutenant. '
              'Outstanding fieldwork, soldier.';
          break;
        case 6:
          milestoneMessage =
              '🔍 Six artefacts down. '
              'Marshal status is almost yours — eyes sharp!';
          break;
        case 7:
          milestoneMessage =
              '🏅 Marshal Unlocked! '
              'You’ve conquered the museum’s past like a true commander!';
          break;
        default:
          milestoneMessage =
              '🎯 Marshal status maintained! '
              'Keep exploring to discover even more of the museum’s hidden history.';
          break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Artefact',
          style: TextStyle(
            color: Colors.black,
            fontSize: resp.fontSize(24),
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: resp.getHorizontalSpacing(8)),
          child: CircleButton(
            icon: Icons.arrow_back,
            onPressed: () => Navigator.pop(context),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ),
        leadingWidth: resp.scaleWidth(64),
      ),
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
                  padding: EdgeInsets.only(
                    top: resp.getVerticalSpacing(40),
                    left: resp.getHorizontalSpacing(40),
                    right: resp.getHorizontalSpacing(40),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: resp.scaleHeight(273),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child:
                        artefact?.imageFile != null
                            ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(artefact!.imageFile!, fit: BoxFit.cover),
                            )
                            : const Center(child: Icon(Icons.image, color: Colors.white54, size: 60)),
                  ),
                ),

                const Spacer(),

                // Bottom section
                Container(
                  width: double.infinity,
                  height: resp.scaleHeight(300),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(resp.scaleWidth(50)),
                      topRight: Radius.circular(resp.scaleWidth(50)),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: resp.getHorizontalSpacing(40),
                    vertical: resp.getVerticalSpacing(30),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (milestoneMessage != null)
                        Padding(
                          padding: EdgeInsets.only(bottom: resp.getVerticalSpacing(12)),
                          child: Text(
                            milestoneMessage,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: resp.fontSize(16),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      if (!isNew && fromScanner)
                        Padding(
                          padding: EdgeInsets.only(bottom: resp.getVerticalSpacing(12)),
                          child: Text(
                            '⚠️ You\'ve already scanned this artefact.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.yellow,
                              fontSize: resp.fontSize(14),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                      Text(
                        artefact!.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: resp.fontSize(20), fontWeight: FontWeight.w700),
                      ),

                      SizedBox(height: resp.getVerticalSpacing(8)),

                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            artefact.description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: resp.fontSize(16),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
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
