import 'package:flutter/material.dart';
import '../models/medal_tracker.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/circle_button.dart';
import '../utils/responsive_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/sidebar_menu.dart';

class MedalsScreen extends StatelessWidget {
  const MedalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final medals = MedalTracker().earnedMedals;
    final scanned = MedalTracker().scannedCount;
    final resp = ResponsiveUtils.instance;
    resp.init(context);

    String progressMessage = '';
    if (scanned == 0) {
      progressMessage = 'No medals yet. Scan artefacts to earn them!';
    } else if (scanned >= 1 && scanned < 3) {
      progressMessage = 'Keep scanning to become a Sergeant!';
    } else if (scanned >= 3 && scanned < 5) {
      progressMessage = 'Great job! You\'re a Sergeant. Aim for Lieutenant!';
    } else if (scanned >= 5 && scanned < 7) {
      progressMessage = 'Lieutenant rank unlocked! Keep pushing for Marshal!';
    } else if (scanned >= 7 && scanned < 9) {
      progressMessage = 'You\'ve reached Marshal! Outstanding work, keep it up!';
    } else {
      progressMessage = 'You\'ve surpassed expectations, soldier! True museum hero!';
    }

    // Map each rank to its scan threshold and asset image
    final ranks = [
      {
        'label': 'Private',
        'required': 1,
        'asset': 'assets/icons/Bronze.svg',
      },
      {
        'label': 'Sergeant',
        'required': 3,
        'asset': 'assets/icons/Silver.svg',
      },
      {
        'label': 'Lieutenant',
        'required': 5,
        'asset': 'assets/icons/Gold.svg',
      },
      {
        'label': 'Marshal',
        'required': 7,
        'asset': '',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Header Row with sidebar and centered title
          Positioned(
            top: resp.scaleHeight(60),
            left: 0,
            right: 0,
            child: SizedBox(
              height: resp.scaleHeight(70),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Sidebar menu button on the left
                  Positioned(
                    left: resp.scaleWidth(11),
                    child: CircleButton(
                      icon: Icons.more_vert,
                      backgroundColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierColor: Colors.black.withValues(alpha: 0.5),
                          builder: (context) => const SideBarMenu(),
                        );
                      },
                    ),
                  ),

                  // Centered Title
                  Center(
                    child: Text(
                      'Medals',
                      style: TextStyle(
                        fontSize: resp.fontSize(24),
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Inter',
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Military Rank Title
          Positioned(
            top: resp.scaleHeight(130),
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
            top: resp.scaleHeight(195),
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
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: isEarned
                          ? Center(
                        child: SvgPicture.asset(
                          rank['asset'] as String,
                          width: resp.scaleWidth(40), // Smaller size to fit inside circle
                          height: resp.scaleWidth(40),
                        ),
                      )
                          : const Icon(Icons.lock, color: Colors.black),
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


          Positioned(
            top: resp.scaleHeight(340),
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                progressMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: resp.fontSize(16),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          // Bottom-right image decoration
          Positioned(
            bottom: resp.scaleHeight(20),
            right: resp.scaleWidth(-20),
            child: Image.asset(
              'lib/img/teddy/4-CharlieScout-A4-Noback.png',
              width: resp.scaleWidth(300),
              height: resp.scaleHeight(300),
            ),
          ),
        ],
      ),

      // Bottom Navigation
      bottomNavigationBar: const CustomNavigationBar(currentIndex: 3),
    );
  }
}
