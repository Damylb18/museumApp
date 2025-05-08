import 'package:flutter/material.dart';
import 'package:cheshire_military_museum_tour/utils/responsive_utils.dart';
import 'scan_qr_screen.dart';
import 'webview_screen.dart';
import 'medals_screen.dart';

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
        leading: IconButton(
          icon: Icon(
            Icons.more_vert,
            color: const Color(0xFF72745D),
            size: resp.iconSize(24),
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: const Color(0xFF72745D),
              size: resp.iconSize(24),
            ),
            onPressed: () {},
          ),
        ],
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
                    _buildCircleIcon(context, Icons.shopping_bag, 'Shop', resp),
                    _buildCircleIcon(context, Icons.confirmation_num, 'Tickets', resp),
                    _buildCircleIcon(context, Icons.volunteer_activism, 'Donate', resp),
                    _buildCircleIcon(context, Icons.event, 'Events', resp),
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
            icon: Icon(Icons.home_mini_rounded, size: resp.iconSize(24)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner, size: resp.iconSize(24)),
            label: 'Scan QR',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(Icons.favorite, size: resp.iconSize(24)),
                Positioned(
                  right: resp.scaleWidth(-6),
                  top: resp.scaleHeight(-2),
                  child: CircleAvatar(
                    radius: resp.scaleWidth(7),
                    backgroundColor: Colors.red,
                    child: Text(
                      '9',
                      style: TextStyle(
                        fontSize: resp.fontSize(10),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.military_tech, size: resp.iconSize(24)),
            label: 'Medals',
          ),
        ],
      ),
    );
  }

  Widget _buildCircleIcon(
      BuildContext context,
      IconData icon,
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
            } else if (label == 'Events') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WebPageScreen(
                    title: 'Events',
                    //TODO Make link changeable by staff
                    url: 'https://cheshiremilitarymuseum.org.uk/category/event/',
                  ),
                ),
              );
            }
          },
          child: CircleAvatar(
            backgroundColor: const Color(0xFFDBD3BD),
            radius: resp.scaleWidth(30),
            child: IconTheme(
              data: IconThemeData(
                color: Colors.black,
                size: resp.iconSize(24),
              ),
              child: Icon(icon),
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