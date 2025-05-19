import 'package:flutter/material.dart';
import 'package:cheshire_military_museum_tour/screens/home_page.dart';
import 'package:cheshire_military_museum_tour/utils/responsive_utils.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = ResponsiveUtils.instance;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top section with image (flexible area)
            Expanded(
              flex: 6,
              child: Center(
                child: Image.asset(
                  'lib/img/img.png',
                  width: resp.scaleWidth(321),
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Bottom curved section with text and button
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(resp.scaleWidth(50)),
                  topRight: Radius.circular(resp.scaleWidth(50)),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: resp.getHorizontalSpacing(30),
                vertical: resp.getVerticalSpacing(40),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title
                  Text(
                    'The Cheshire Military Museum',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: resp.fontSize(32),
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  SizedBox(height: resp.getVerticalSpacing(30)),

                  // Description
                  Text(
                    'Begin your journey through four centuries of the military in Cheshire at the Cheshire Military Museum.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: resp.fontSize(14),
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  SizedBox(height: resp.getVerticalSpacing(35)),

                  // Go Button - Aligned to the right
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(
                          horizontal: resp.getHorizontalSpacing(24),
                          vertical: resp.getVerticalSpacing(15),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: resp.getBorderRadius(12),
                        ),
                      ),
                      onPressed: () {
                        // Navigate to the Home page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePageTwo()),
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Go',
                            style: TextStyle(
                              fontSize: resp.fontSize(16),
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Inter',
                            ),
                          ),
                          SizedBox(width: resp.getHorizontalSpacing(8)),
                          Icon(
                            Icons.arrow_forward,
                            size: resp.iconSize(20),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: resp.getVerticalSpacing(30)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
