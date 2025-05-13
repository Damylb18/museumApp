import 'package:flutter/material.dart';
import 'package:cheshire_military_museum_tour/utils/responsive_utils.dart';
import 'package:cheshire_military_museum_tour/widgets/custom_icon.dart';
import 'package:cheshire_military_museum_tour/widgets/navigation_bar.dart';
import 'webview_screen.dart';
import 'package:cheshire_military_museum_tour/widgets/circle_button.dart';

class HomePageTwo extends StatelessWidget {
  const HomePageTwo({super.key});

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
                SizedBox(height: resp.getVerticalSpacing(10)),
                Text(
                  'Welcome!',
                  style: TextStyle(
                    fontSize: resp.fontSize(40),
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: resp.getVerticalSpacing(30)),

                SizedBox(
                  height: resp.scaleHeight(400),
                  child: SingleChildScrollView(
                   scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: resp.getHorizontalSpacing(20)),

                  child: Row(
                   children:[
                     //1st Block
                 Container(
                 width: resp.scaleWidth(280),  // Fixed width
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: resp.getBorderRadius(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.5),
                            blurRadius: 20,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                   child: ClipRRect(
                     borderRadius: resp.getBorderRadius(20),
                     child: Image.asset(
                       'lib/img/img2.jpg',
                           fit: BoxFit.cover,
                       // height: resp.scaleHeight(400),
                       // width: resp.scaleWidth(280),
                     ),
                   ),
                      ),
                     SizedBox(width: resp.getHorizontalSpacing(15)),
                  //2nd Block
                     Container(
                       width: resp.scaleWidth(280),  // Fixed width
                       decoration: BoxDecoration(
                         color: Colors.grey[100],
                         borderRadius: resp.getBorderRadius(20),
                         boxShadow: [
                           BoxShadow(
                             color: Colors.grey.withValues(alpha: 0.5),
                             blurRadius: 20,
                             offset: Offset(0, 2),
                           ),
                         ],
                       ),
                       child: ClipRRect(
                         borderRadius: resp.getBorderRadius(20),
                         child: Image.asset(
                           'lib/img/img1.jpg',
                           fit: BoxFit.cover,
                           // height: resp.scaleHeight(400),
                           // width: resp.scaleWidth(280),
                         ),
                       ),
                     ),
                   ],
                 )
                  ),
                ),
                SizedBox(height: resp.getVerticalSpacing(35)),
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
      bottomNavigationBar: const CustomNavigationBar(
        currentIndex: 0,
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
              size: resp.iconSize(30),
            ),
          ),
        ),
        SizedBox(height: resp.getVerticalSpacing(8)),
        Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: resp.fontSize(18),
          ),
        ),
      ],
    );
  }
}