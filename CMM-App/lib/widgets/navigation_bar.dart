import 'package:flutter/material.dart';
import 'package:cheshire_military_museum_tour/utils/responsive_utils.dart';
import 'package:cheshire_military_museum_tour/widgets/custom_icon.dart';
import 'package:cheshire_military_museum_tour/screens/scan_qr_screen.dart';
import 'package:cheshire_military_museum_tour/screens/medals_screen.dart';
import 'package:cheshire_military_museum_tour/screens/home_page_two.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const CustomNavigationBar({
    super.key,
    this.currentIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    final resp = ResponsiveUtils.instance;

    return BottomNavigationBar(
      selectedItemColor: const Color(0xFF72745D),
      unselectedItemColor: Colors.black,
      showUnselectedLabels: true,
      iconSize: resp.iconSize(24),
      selectedFontSize: resp.fontSize(12),
      unselectedFontSize: resp.fontSize(12),
      currentIndex: currentIndex,
      onTap: (index) => _onItemTapped(context, index),
      type: BottomNavigationBarType.fixed, // This ensures equal spacing
      items: [
        BottomNavigationBarItem(
          icon: CustomIcon(
            assetName: 'assets/icons/home.svg',
            size: resp.iconSize(24),
          ),
          activeIcon: CustomIcon(
            assetName: 'assets/icons/home.svg',
            size: resp.iconSize(24),
            color: const Color(0xFF72745D),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: CustomIcon(
            assetName: 'assets/icons/qr.svg',
            size: resp.iconSize(24),
          ),
          activeIcon: CustomIcon(
            assetName: 'assets/icons/qr.svg',
            size: resp.iconSize(24),
            color: const Color(0xFF72745D),
          ),
          label: 'Scan QR',
        ),
        BottomNavigationBarItem(
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              CustomIcon(
                assetName: 'assets/icons/artefact.svg',
                size: resp.iconSize(24),
              ),
            ],
          ),
          activeIcon: CustomIcon(
            assetName: 'assets/icons/artefact.svg',
            size: resp.iconSize(24),
            color: const Color(0xFF72745D),
          ),
          label: 'Artefacts',
        ),
        BottomNavigationBarItem(
          icon: CustomIcon(
            assetName: 'assets/icons/medal.svg',
            size: resp.iconSize(24),
          ),
          activeIcon: CustomIcon(
            assetName: 'assets/icons/medal.svg',
            size: resp.iconSize(24),
            color: const Color(0xFF72745D),
          ),
          label: 'Medals',
        ),
      ],
    );
  }

  void _onItemTapped(BuildContext context, int index) {
    // Don't navigate if we're already on the selected screen
    if (index == currentIndex) return;

    // Handle navigation based on the selected index
    switch (index) {
      case 0:
      // Navigate to Home - handling differently to avoid stacking
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
      case 2:
      // Navigate to Artefacts - commented as it might not be implemented yet
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const ArtefactsScreen()),
      // );
        break;
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