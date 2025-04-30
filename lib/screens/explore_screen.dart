import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              // App bar with explore title and navigation buttons
              Positioned(
                left: 11,
                top: 60,
                child: Container(
                  width: 371,
                  height: 51,
                  child: Stack(
                    children: [
                      // Back button
                      Positioned(   
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: const ShapeDecoration(
                            color: Color(0xFF75775D),
                            shape: OvalBorder(),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                      // Settings button
                      Positioned(
                        left: 323,
                        top: 0,
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: const ShapeDecoration(
                            color: Color(0xFF75775D),
                            shape: OvalBorder(),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.settings, color: Colors.white),
                            onPressed: () {
                              // TODO: Add settings action
                            },
                          ),
                        ),
                      ),
                      // Page title
                      const Positioned(
                        left: 127,
                        top: 11,
                        child: SizedBox(
                          width: 104,
                          height: 26,
                          child: Text(
                            'Explore',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // War Room card
              Positioned(
                left: 10,
                top: 137,
                child: Container(
                  width: 373,
                  height: 168,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFDCCFBB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Close button
                      Positioned(
                        right: 14,
                        top: 14,
                        child: Container(
                          width: 30,
                          height: 29,
                          decoration: const ShapeDecoration(
                            color: Colors.black,
                            shape: OvalBorder(),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.close, color: Colors.white, size: 16),
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              // TODO: Add close action
                            },
                          ),
                        ),
                      ),

                      // Image placeholder
                      Positioned(
                        left: 18,
                        top: 145 - 137,
                        child: Container(
                          width: 83,
                          height: 153,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Center(
                            child: Icon(Icons.image, size: 40, color: Colors.grey),
                          ),
                        ),
                      ),

                      // Title
                      const Positioned(
                        left: 117 - 10,
                        top: 156 - 137,
                        child: SizedBox(
                          width: 263,
                          height: 23,
                          child: Text(
                            'War Room',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

                      // Floor info
                      const Positioned(
                        left: 117 - 10,
                        top: 184 - 137,
                        child: SizedBox(
                          width: 171,
                          height: 26,
                          child: Text(
                            '(FLOOR -2A)',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),

                      // Divider line
                      Positioned(
                        left: 117 - 10,
                        top: 221 - 137,
                        child: Container(
                          width: 253,
                          height: 1,
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ),

                      // Distance
                      const Positioned(
                        left: 117 - 10,
                        top: 226 - 137,
                        child: SizedBox(
                          width: 51,
                          height: 23,
                          child: Text(
                            '35m',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

                      const Positioned(
                        left: 117 - 10,
                        top: 249 - 137,
                        child: SizedBox(
                          width: 63,
                          height: 14,
                          child: Text(
                            'Distance',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),

                      // Time
                      const Positioned(
                        left: 197 - 10,
                        top: 226 - 137,
                        child: SizedBox(
                          width: 80,
                          height: 26,
                          child: Text(
                            '5 min',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

                      const Positioned(
                        left: 197 - 10,
                        top: 249 - 137,
                        child: SizedBox(
                          width: 47,
                          height: 14,
                          child: Text(
                            'Time',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),

                      // Steps
                      const Positioned(
                        left: 279 - 10,
                        top: 226 - 137,
                        child: SizedBox(
                          width: 75,
                          height: 27,
                          child: Text(
                            '5 of 20',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

                      const Positioned(
                        left: 279 - 10,
                        top: 249 - 137,
                        child: SizedBox(
                          width: 47,
                          height: 14,
                          child: Text(
                            'Steps',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Map markers
              // Marker 1
              Positioned(
                left: 270,
                top: 408,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFB82F39),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      '1',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),

              // Marker 2
              Positioned(
                left: 110,
                top: 471,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFB82F39),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      '2',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),

              // Bottom navigation area
              // Distance indicator
              Positioned(
                left: 104,
                top: 753,
                child: Container(
                  width: 184,
                  height: 62,
                  decoration: ShapeDecoration(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Direction icon container
                      Container(
                        margin: const EdgeInsets.only(left: 9),
                        width: 45,
                        height: 45,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_upward,
                          color: Colors.black,
                        ),
                      ),
                      // Distance text
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              '18 meters',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Walking straight',
                              style: TextStyle(
                                color: Color(0xFF878383),
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom action buttons
              // Discover button
              Positioned(
                left: 17,
                top: 757,
                child: Column(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: const ShapeDecoration(
                        color: Color(0xFF75775D),
                        shape: OvalBorder(),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.explore, color: Colors.white),
                        onPressed: () {
                          // Already on discover/explore screen
                        },
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Discover',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              // Scan QR button
              Positioned(
                left: 312,
                top: 757,
                child: Column(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: const ShapeDecoration(
                        color: Color(0xFF75775D),
                        shape: OvalBorder(),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
                        onPressed: () {
                          // TODO: Add QR code scanning functionality
                        },
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Scan QR',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              // Home indicator
              Positioned(
                left: 129,
                top: 841,
                child: Container(
                  width: 134,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}