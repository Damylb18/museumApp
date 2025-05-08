import 'package:flutter/material.dart';
import '../models/medal_tracker.dart';

class ArtefactDetailScreen extends StatelessWidget {
  final String artefactId;
  final bool isNew;

  const ArtefactDetailScreen({
    required this.artefactId,
    required this.isNew,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          milestoneMessage = '🎉 Congrats on finding your second artefact! 🎉 Find one more to win your Bronze Historian medal!';
          break;
        case 3:
          milestoneMessage = '🏅 Bronze Historian Unlocked! Keep scanning to earn Silver!';
          break;
        case 4:
          milestoneMessage = '📜 Four artefacts found! One more for Silver Historian!';
          break;
        case 5:
          milestoneMessage = '🥈 Silver Historian Unlocked! You’re doing great!';
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
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF595B41),
          foregroundColor: Colors.white,
        ),
      ),
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: 393,
              height: 852,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(color: Colors.white),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      height: 53,
                      width: 393,
                      child: AppBar(
                        title: const Text('Artefact'),
                        leading: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                  ),

                  // Top image placeholder
                  const Positioned(
                    left: 40,
                    top: 153,
                    child: SizedBox(
                      width: 303,
                      height: 273,
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: Color(0xFF545555)),
                      ),
                    ),
                  ),

                  // Bottom background curve
                  const Positioned(
                    left: 0,
                    top: 495,
                    child: SizedBox(
                      width: 393,
                      height: 357,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color(0xFF595B41),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Artefact Details and Messages
                  Positioned(
                    top: 529,
                    left: 52,
                    right: 52,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (milestoneMessage != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Text(
                              milestoneMessage,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        if (!isNew)
                          const Padding(
                            padding: EdgeInsets.only(bottom: 12.0),
                            child: Text(
                              '⚠️ You’ve already scanned this artefact.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.yellow,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                        // TODO: Replace with actual artefact name
                        const Text(
                          'Name of Artefact',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // TODO: Replace with actual artefact description
                        const Text(
                          'Artefact description retrieved from database\n',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Play button (non-functional)
                  Positioned(
                    left: 237,
                    top: 759,
                    child: Container(
                      width: 112.68,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                          bottomLeft: Radius.circular(50),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Play',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
