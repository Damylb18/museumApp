import 'package:flutter/material.dart';
import 'package:cheshire_military_museum_tour/utils/responsive_utils.dart';
import 'package:cheshire_military_museum_tour/screens/scan_qr_screen.dart';
import 'package:cheshire_military_museum_tour/screens/medals_screen.dart';
import 'package:cheshire_military_museum_tour/screens/home_page_two.dart';

class FloatingNavBar extends StatelessWidget {
  final int currentIndex;
  final bool showBadge;
  final int badgeCount;

  const FloatingNavBar({
    super. key,
    required this.currentIndex,
    this.showBadge = false,
    this.badgeCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    final resp = ResponsiveUtils.instance;

    return Padding(
      padding: EdgeInsets.only(
        left: resp.getHorizontalSpacing(15),
        right: resp.getHorizontalSpacing(15),
        bottom: resp.getVerticalSpacing(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(resp.scaleWidth(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: resp.getVerticalSpacing(10),
            horizontal: resp.getHorizontalSpacing(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(
                  context,
                  Icons.home_mini_rounded,
                  'Home',
                  0,
                  resp
              ),
              _buildNavItem(
                  context,
                  Icons.qr_code_scanner,
                  'Scan QR',
                  1,
                  resp
              ),
              _buildNavItem(
                context,
                Icons.favorite,
                'Saved',
                2,
                resp,
                showBadge: showBadge,
                badgeCount: badgeCount,
              ),
              _buildNavItem(
                  context,
                  Icons.military_tech,
                  'Medals',
                  3,
                  resp
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      BuildContext context,
      IconData icon,
      String label,
      int index,
      ResponsiveUtils resp, {
        bool showBadge = false,
        int badgeCount = 0,
      }) {
    final isSelected = currentIndex == index;
    final color = isSelected ? const Color(0xFF72745D) : Colors.grey;

    return Expanded(
      child: GestureDetector(
        onTap: () => _onItemTapped(context, index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  icon,
                  color: color,
                  size: resp.iconSize(24),
                ),
                if (index == 2 && showBadge)
                  Positioned(
                    right: resp.scaleWidth(-6),
                    top: resp.scaleHeight(-2),
                    child: CircleAvatar(
                      radius: resp.scaleWidth(7),
                      backgroundColor: Colors.red,
                      child: Text(
                        badgeCount.toString(),
                        style: TextStyle(
                          fontSize: resp.fontSize(10),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: resp.getVerticalSpacing(4)),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: resp.fontSize(12),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(BuildContext context, int index) {
    // Do nothing if we're already on the selected screen
    if (index == currentIndex) return;

    // Otherwise navigate to the appropriate screen
    switch (index) {
      case 0:
      // Navigate to Home
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePageTwo()),
              (route) => false,
        );
        break;
      case 1:
      // Navigate to Scan QR
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ScanQRScreen()),
        );
        break;
        //Uncomment this section after creating saved artefacts screen.
      // case 2:
      // // Navigate to Saved
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => const SavedArtefactsScreen()),
      //   );
      //   break;
      case 3:
      // Navigate to Medals
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MedalsScreen()),
        );
        break;
    }
  }
}