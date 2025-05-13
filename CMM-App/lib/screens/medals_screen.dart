import 'package:flutter/material.dart';
import '../models/medal_tracker.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/circle_button.dart';
import '../utils/responsive_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MedalsScreen extends StatelessWidget {
  const MedalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final medals = MedalTracker().earnedMedals;
    final scanned = MedalTracker().scannedCount;
    final resp = ResponsiveUtils.instance;
    resp.init(context);

    // Map each rank to its scan threshold and asset image
    final ranks = [
      {
        'label': 'Bronze Explorer',
        'required': 3,
        'asset': 'assets/icons/Bronze.svg',
      },
      {
        'label': 'Silver Historian',
        'required': 5,
        'asset': 'assets/icons/Silver.svg',
      },
      {
        'label': 'Gold Curator',
        'required': 7,
        'asset': 'assets/icons/Gold.svg',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Header Row with back button and title
          Positioned(
            top: resp.scaleHeight(60),
            left: resp.scaleWidth(11),
            right: resp.scaleWidth(11),
            child: Row(
              children: [
                CircleButton(
                  icon: Icons.arrow_back,
                  backgroundColor: const Color(0xFF595B41),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(width: resp.scaleWidth(16)),
                Text(
                  'Medals',
                  style: TextStyle(
                    fontSize: resp.fontSize(24),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          // Military Rank Title
          Positioned(
            top: resp.scaleHeight(152),
            left: resp.scaleWidth(22),
            child: Text(
              'Military Rank',
              style: TextStyle(
                fontSize: resp.fontSize(32),
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
                color: Colors.black,
              ),
            ),
          ),

          // Medals Row
          Positioned(
            top: resp.scaleHeight(215),
            left: resp.scaleWidth(21),
            right: resp.scaleWidth(21),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ranks.map((rank) {
                final isEarned = scanned >= (rank['required'] as int);
                return Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 600),
                      width: resp.scaleWidth(70),
                      height: resp.scaleWidth(70),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFDCCFBB),
                      ),
                      child: isEarned
                          ? SvgPicture.asset(
                              rank['asset'] as String,
                              width: resp.scaleWidth(70),
                              height: resp.scaleWidth(70),
                          )
                          : const Icon(Icons.lock, color: Colors.brown),
                    ),
          SizedBox(height: resp.scaleHeight(8)),
          Text(
            rank['label'] as String,
            style: TextStyle(
              fontSize: resp.fontSize(14),
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
              color: Colors.black,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),


          // Informational note if no medals earned
          if (medals.isEmpty)
            Positioned(
              top: resp.scaleHeight(340),
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'No medals yet. Scan artefacts to earn them!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: resp.fontSize(16),
                  ),
                ),
              ),
            ),

          // Bottom-right image decoration
          Positioned(
            bottom: resp.scaleHeight(20),
            right: resp.scaleWidth(20),
            child: Image.asset(
              'lib/img/CharlieScout.png',
              width: resp.scaleWidth(200), // Adjust as needed
              height: resp.scaleHeight(200),
            ),
          ),
        ],
      ),

      // Bottom Navigation
      bottomNavigationBar: const CustomNavigationBar(currentIndex: 3),
    );
  }
}
