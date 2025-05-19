import 'package:flutter/material.dart';
import 'package:cheshire_military_museum_tour/utils/responsive_utils.dart';
import 'package:cheshire_military_museum_tour/widgets/custom_icon.dart';
import 'package:cheshire_military_museum_tour/widgets/navigation_bar.dart';
import '../utils/navigation_utils.dart';
import 'package:cheshire_military_museum_tour/widgets/circle_button.dart';
import 'package:cheshire_military_museum_tour/widgets/sidebar_menu.dart';

class HomePageTwo extends StatelessWidget {
  const HomePageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = ResponsiveUtils.instance;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                scrolledUnderElevation: 0,
                leading: Padding(
                  padding: EdgeInsets.only(left: resp.getHorizontalSpacing(8)),
                  child: CircleButton(
                    icon: Icons.more_vert,
                    onPressed: () {
                      // Sidebar
                      showDialog(
                        context: context,
                        barrierColor: Colors.black.withOpacity(0.5),
                        builder: (context) => const SideBarMenu(),
                      );
                    },
                    backgroundColor: const Color(0xFF72745D),
                  ),
                ),
                leadingWidth: resp.scaleWidth(64),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: resp.getHorizontalSpacing(20),
                          top: resp.getVerticalSpacing(40),
                          right: resp.getHorizontalSpacing(20),
                        ),
                        child: Text(
                          'Welcome!',
                          style: TextStyle(
                            fontSize: resp.fontSize(40),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: resp.getVerticalSpacing(30)),
                      SizedBox(
                        height: resp.scaleHeight(400),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              SizedBox(width: resp.getHorizontalSpacing(20)),
                              Container(
                                width: resp.scaleWidth(280),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: resp.getBorderRadius(20),
                                ),
                                child: ClipRRect(
                                  borderRadius: resp.getBorderRadius(20),
                                  child: Image.asset(
                                    'lib/img/img2.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: resp.getHorizontalSpacing(15)),
                              Container(
                                width: resp.scaleWidth(280),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: resp.getBorderRadius(20),
                                ),
                                child: ClipRRect(
                                  borderRadius: resp.getBorderRadius(20),
                                  child: Image.asset(
                                    'lib/img/img1.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: resp.getHorizontalSpacing(20)),
                            ],
                          ),
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
              bottomNavigationBar: const CustomNavigationBar(
                currentIndex: 0,
              ),
            ),
          ),
          Positioned(
            top: resp.getVerticalSpacing(70),
            right: resp.getHorizontalSpacing(15),
            child: Image.asset(
              'lib/img/teddy/10-CharlieUniform-A2-Noback.png',
              width: resp.scaleWidth(100),
              height: resp.scaleHeight(140),
            ),
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
              NavigationUtils.openWebPage(
                context,
                'Shop',
                'https://museumsofcheshire.org.uk/shopping',
              );
            } else if (label == 'Tickets') {
              NavigationUtils.openWebPage(
                context,
                'Tickets',
                'https://cheshiremilitarymuseum.org.uk/product/adult-ticket/',
              );
            } else if (label == 'Donate') {
              NavigationUtils.openWebPage(
                context,
                'Donate',
                'https://cheshiremilitarymuseum.org.uk/friends/',
              );
            } else if (label == 'News') {
              NavigationUtils.openWebPage(
                context,
                'News',
                'https://cheshiremilitarymuseum.org.uk/news/',
              );
            }
          }
          ,
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
