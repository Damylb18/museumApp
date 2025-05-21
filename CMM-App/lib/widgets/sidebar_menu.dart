

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/navigation_utils.dart';
import '../utils/url_utils.dart';

class SideBarMenu extends StatelessWidget {
  const SideBarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        color: Colors.transparent,
        child: Container(
          // Sidebar width: 75% of screen
          width: MediaQuery.of(context).size.width * 0.75,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Close button
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              const SizedBox(height: 10),
              // "Contact Us" link
              ListTile(
                leading: const Icon(Icons.phone, color: Colors.white),
                title: const Text('Contact us', style: TextStyle(color: Colors.white)),
                onTap: () {
                  NavigationUtils.openWebPage(
                    context,
                    'Contact Us',
                    'https://cheshiremilitarymuseum.org.uk/contact/',
                  );
                },
              ),
              // "Privacy Policy" link
              ListTile(
                leading: const Icon(Icons.lock, color: Colors.white),
                title: const Text('Privacy Policy', style: TextStyle(color: Colors.white)),
                onTap: () {
                  NavigationUtils.openWebPage(
                    context,
                    'Privacy Policy',
                    'https://cheshiremilitarymuseum.org.uk/privacy-policy/',
                  );
                },
              ),
              const Spacer(),
              // Social media icons row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                        color: Colors.blue[800],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.facebook, color: Colors.white, size: 24),
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
                      decoration: const BoxDecoration(
                        color: Colors.pinkAccent,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: SvgPicture.asset(
                        'assets/icons/Instagram.svg',
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
                      decoration: const BoxDecoration(
                        color: Color(0xFF00AF87),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(6.0),
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
  }
}
