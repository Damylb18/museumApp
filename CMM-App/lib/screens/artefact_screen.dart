import 'dart:io';

import 'package:cheshire_military_museum_tour/services/artefact_service.dart';
import 'package:flutter/material.dart';
import '../models/artefact.dart';
import '../models/medal_tracker.dart';
import '../utils/responsive_utils.dart';

class ArtefactDetailScreen extends StatelessWidget {
  final String artefactId;
  final bool isNew;

  final ArtefactService artefactService = ArtefactService();

  Future<Map<String, dynamic>> _loadArtifactAndImage() async {
    final artefact = await artefactService.getArtefactById(artefactId);
    final imageFile = await artefactService.getArtefactImage(artefactId);
    return {'artefact': artefact, 'image': imageFile};
  }

  ArtefactDetailScreen({required this.artefactId, required this.isNew, super.key});

  @override
  Widget build(BuildContext context) {
    final resp = ResponsiveUtils.instance;
    final tracker = MedalTracker();
    final scannedCount = tracker.scannedCount;

    // Select a milestone message based on progress
    String? milestoneMessage;
    if (isNew) {
      switch (scannedCount) {
        case 1:
          milestoneMessage = '🎉 Congrats on finding your first artefact! 🎉 Find more to win medals!';
          break;
        case 2:
          milestoneMessage =
              '🎉 Congrats on finding your second artefact! 🎉 Find one more to win your Bronze Historian medal!';
          break;
        case 3:
          milestoneMessage = '🏅 Bronze Historian Unlocked! Keep scanning to earn Silver!';
          break;
        case 4:
          milestoneMessage = '📜 Four artefacts found! One more for Silver Historian!';
          break;
        case 5:
          milestoneMessage = '🥈 Silver Historian Unlocked! You\'re doing great!';
          break;
        case 6:
          milestoneMessage = 'Six down! Almost there for the Gold!';
          break;
        case 7:
          milestoneMessage = '🥇 Gold Historian Unlocked! Incredible effort!';
          break;
      }
    }

    return Theme(
      data: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF595B41), foregroundColor: Colors.white),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Artefact', style: TextStyle(fontSize: resp.fontSize(18))),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, size: resp.iconSize(24)),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: FutureBuilder<Map<String, dynamic>>(
            future: _loadArtifactAndImage(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error loading artefact: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!['artefact'] == null) {
                return const Center(child: Text('Artefact not found.'));
              }

              final artefact = snapshot.data!['artefact'] as Artefact;
              final imageFile = snapshot.data!['image'] as File?;

              return Column(
                children: [
                  // Top image section (can be updated later to load image from artefact.imageUrl)
                  Padding(
                    padding: EdgeInsets.only(
                      top: resp.getVerticalSpacing(100),
                      left: resp.getHorizontalSpacing(40),
                      right: resp.getHorizontalSpacing(40),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: resp.scaleHeight(273),
                      decoration: const BoxDecoration(
                        color: Color(0xFF545555),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child:
                          imageFile != null
                              ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(imageFile, fit: BoxFit.cover),
                              )
                              : const Center(child: Icon(Icons.image, color: Colors.white54, size: 60)),
                    ),
                  ),

                  const Spacer(),

                  // Bottom section
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF595B41),
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
                        if (!isNew)
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
                          artefact.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: resp.fontSize(20),
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        SizedBox(height: resp.getVerticalSpacing(8)),

                        Text(
                          artefact.description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: resp.fontSize(16),
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        SizedBox(height: resp.getVerticalSpacing(30)),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                padding: EdgeInsets.symmetric(
                                  horizontal: resp.getHorizontalSpacing(24),
                                  vertical: resp.getVerticalSpacing(15),
                                ),
                                shape: RoundedRectangleBorder(borderRadius: resp.getBorderRadius(50)),
                              ),
                              onPressed: () {
                                // TODO: Implement play functionality
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.play_arrow, size: resp.iconSize(20)),
                                  SizedBox(width: resp.getHorizontalSpacing(4)),
                                  Text(
                                    'Play',
                                    style: TextStyle(fontSize: resp.fontSize(16), fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: resp.getVerticalSpacing(20)),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
