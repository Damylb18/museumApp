import 'package:flutter/material.dart';
import 'package:cheshire_military_museum_tour/utils/responsive_utils.dart';
import 'package:cheshire_military_museum_tour/widgets/custom_icon.dart';
import 'scan_qr_screen.dart';
import 'webview_screen.dart';
import 'medals_screen.dart';
import 'package:cheshire_military_museum_tour/widgets/circle_button.dart';

class HomePageTwo extends StatelessWidget {
  const HomePageTwo({super. key});

  @override
  Widget build(BuildContext context) {
    final resp = ResponsiveUtils.instance;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: resp.getHorizontalSpacing(8)),
          child: CircleButton(
            icon: Icons.more_vert,
            onPressed: () {
              // Menu action
            },
            backgroundColor: const Color(0xFF72745D),
          ),
        ),
        leadingWidth: resp.scaleWidth(64), // Ensure enough space for the button
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(resp.getHorizontalSpacing(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome!',
                  style: TextStyle(
                    fontSize: resp.fontSize(26),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: resp.getVerticalSpacing(20)),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: resp.scaleHeight(520),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: resp.getBorderRadius(12),
                        ),
                      ),
                    ),
                    SizedBox(width: resp.getHorizontalSpacing(15)),
                    Expanded(
                      child: Container(
                        height: resp.scaleHeight(520),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: resp.getBorderRadius(12),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: resp.getVerticalSpacing(30)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCircleIcon(context, 'assets/icons/shop.svg', 'Shop', resp),
                    _buildCircleIcon(context, 'assets/icons/tickets.svg', 'Tickets', resp),
                    _buildCircleIcon(context, 'assets/icons/donate.svg', 'Donate', resp),
                    _buildCircleIcon(context, 'assets/icons/news.svg', 'News', resp),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF72745D),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        iconSize: resp.iconSize(24),
        selectedFontSize: resp.fontSize(12),
        unselectedFontSize: resp.fontSize(12),
        currentIndex: 0,
        onTap: (index) {
           if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ScanQRScreen()),
            );
          }
           else if (index == 3){
             Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => const MedalsScreen()),
             );
           }
        },
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
            icon: CustomIcon(
              assetName: 'assets/icons/artefact.svg',
              size: resp.iconSize(24),
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
      ),
    );
  }

  Widget _buildCircleIcon(
      BuildContext context,
      String iconsAsset,
      String label,
      ResponsiveUtils resp,
      ) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (label == 'Shop') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WebPageScreen(
                    title: 'Shop',
                    //TODO Make link changeable by staff
                    url: 'https://museumsofcheshire.org.uk/shopping',
                  ),
                ),
              );
            } else if (label == 'Tickets') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WebPageScreen(
                    title: 'Tickets',
                    //TODO Make link changeable by staff
                    url: 'https://cheshiremilitarymuseum.org.uk/product/adult-ticket/',
                  ),
                ),
              );
            } else if (label == 'Donate') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WebPageScreen(
                    title: 'Donate',
                    //TODO Make link changeable by staff
                    url: 'https://cheshiremilitarymuseum.org.uk/friends/',
                  ),
                ),
              );
            } else if (label == 'News') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WebPageScreen(
                    title: 'Events',
                    //TODO Make link changeable by staff
                    url: 'https://cheshiremilitarymuseum.org.uk/news/',
                  ),
                ),
              );
            }
          },
          child: CircleAvatar(
            backgroundColor: const Color(0xFFDBD3BD),
            radius: resp.scaleWidth(30),
            child: CustomIcon(
            assetName: iconsAsset,
                color: Colors.black,
                size: resp.iconSize(24),
              ),
            ),
          ),
        SizedBox(height: resp.getVerticalSpacing(8)),
        Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: resp.fontSize(14),
          ),
        ),
      ],
    );
  }

}