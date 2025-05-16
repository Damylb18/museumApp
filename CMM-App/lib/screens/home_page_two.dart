import 'package:flutter/material.dart';
import 'package:cheshire_military_museum_tour/utils/responsive_utils.dart';
import 'package:cheshire_military_museum_tour/widgets/custom_icon.dart';
import 'package:cheshire_military_museum_tour/widgets/navigation_bar.dart';
import 'package:cheshire_military_museum_tour/widgets/circle_button.dart';
import 'package:cheshire_military_museum_tour/utils/navigation_utils.dart';
import 'package:cheshire_military_museum_tour/utils/url_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePageTwo extends StatelessWidget {
  const HomePageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = ResponsiveUtils.instance; // Responsive utils instance

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
              // Show side menu dialog
              showDialog(
                context: context,
                barrierColor: Colors.black.withOpacity(0.5),
                builder: (context) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 40, horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                icon: const Icon(Icons.close, color: Colors.white),
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close dialog
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            ListTile(
                              leading: const Icon(Icons.phone, color: Colors.white),
                              title: const Text('Contact us',
                                  style: TextStyle(color: Colors.white)),
                              onTap: () {
                                // Open Contact Us page
                                NavigationUtils.openWebPage(
                                  context,
                                  'Contact Us',
                                  'https://cheshiremilitarymuseum.org.uk/contact/',
                                );
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.lock, color: Colors.white),
                              title: const Text('Privacy Policy',
                                  style: TextStyle(color: Colors.white)),
                              onTap: () {
                                // Open Privacy Policy page
                                NavigationUtils.openWebPage(
                                  context,
                                  'Privacy Policy',
                                  'https://cheshiremilitarymuseum.org.uk/privacy-policy/',
                                );
                              },
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Facebook button with circle background
                                GestureDetector(
                                  onTap: () {
                                    UrlUtils.openExternalUrl(
                                      context,
                                      'https://www.facebook.com/cheshiremilitarymuseum',
                                    );

                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[800], // Facebook blue
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.facebook,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                GestureDetector(
                                  onTap: () {
                                    UrlUtils.openExternalUrl(
                                      context,
                                      'https://www.instagram.com/cheshiremilitarymuseum',
                                    );
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.pinkAccent, // Instagram pinkish
                                      shape: BoxShape.circle,
                                    ),
                                    padding: const EdgeInsets.all(8), // padding inside the circle
                                    child: SvgPicture.asset(
                                      'assets/icons/instagram.svg',
                                      color: Colors.white,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                IconButton(
                                  onPressed: () {
                                    UrlUtils.openExternalUrl(
                                      context,
                                      'https://www.tripadvisor.com/Attraction_Review-g186390-d212257-Reviews-Cheshire_Military_Museum-Chester_Cheshire_England.html',
                                    );
                                  },
                                  icon: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF00AF87), // TripAdvisor green
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: SvgPicture.asset(
                                          'assets/icons/tripadvisor.svg',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },

            backgroundColor: const Color(0xFF72745D),
          ),
        ),
        leadingWidth: resp.scaleWidth(64), // Space for button
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
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
                        padding: EdgeInsets.symmetric(
                            horizontal: resp.getHorizontalSpacing(20)),
                        child: Row(
                          children: [
                            // 1st image block
                            Container(
                              width: resp.scaleWidth(280),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: resp.getBorderRadius(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 20,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
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
                            // 2nd image block
                            Container(
                              width: resp.scaleWidth(280),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: resp.getBorderRadius(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 20,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: resp.getBorderRadius(20),
                                child: Image.asset(
                                  'lib/img/img1.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
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
            // CharlieBlue image top right
            Positioned(
              top: resp.getVerticalSpacing(10),
              right: resp.getHorizontalSpacing(10),
              child: Image.asset(
                'lib/img/CharlieBlue.png',
                width: resp.scaleWidth(100),
                height: resp.scaleHeight(100),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(
        currentIndex: 0,
      ),
    );
  }

  // Circle icon widget builder
  Widget _buildCircleIcon(BuildContext context, String iconsAsset, String label, ResponsiveUtils resp) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            // Open relevant web page by label
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
