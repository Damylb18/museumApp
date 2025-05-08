import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:cheshire_military_museum_tour/utils/responsive_utils.dart';
import 'package:cheshire_military_museum_tour/screens/artefact_screen.dart';
import '../models/medal_tracker.dart';

class ScanQRScreen extends StatefulWidget {
  const ScanQRScreen({super.key});

  @override
  State<ScanQRScreen> createState() => _ScanQRScreenState();
}

class _ScanQRScreenState extends State<ScanQRScreen> {
  final MobileScannerController controller = MobileScannerController();
  bool _hasScanned = false;
  String _scanResult = "";

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resp = ResponsiveUtils.instance;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // App bar with title and navigation buttons
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: resp.getHorizontalSpacing(16),
                vertical: resp.getVerticalSpacing(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back button
                  _buildCircleButton(
                    context,
                    Icons.arrow_back,
                        () => Navigator.pop(context),
                    resp,
                  ),

                  // Title
                  Text(
                    'Scan QR',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: resp.fontSize(24),
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  // Settings button
                  _buildCircleButton(
                    context,
                    Icons.settings,
                        () {}, // Settings action
                    resp,
                  ),
                ],
              ),
            ),

            SizedBox(height: resp.getVerticalSpacing(20)),

            // QR Scanner
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(resp.getHorizontalSpacing(65)), // Padding on all sides
                child: Center(  // Center the scanner container
                  child: AspectRatio(  // Maintain square aspect ratio
                    aspectRatio: 1.0,  // 1:1 ratio for square
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: resp.getBorderRadius(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.6),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: _hasScanned
                          ? Center(
                        child: Text(
                          _scanResult,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: resp.fontSize(16),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                          : MobileScanner(
                        controller: controller,
                        onDetect: (capture) {
                          final List<Barcode> barcodes = capture.barcodes;
                          if (barcodes.isNotEmpty) {
                          final String code = barcodes.first.rawValue ?? 'Failed to scan';

                          if (!_hasScanned) {
                          setState(() {
                          _hasScanned = true;
                          _scanResult = code;
                          });

                          final bool isNew = MedalTracker().addScan(code);

                          // Navigate to artefact detail screen
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context) => ArtefactDetailScreen(
                          artefactId: code, // Pass the scanned code as the ID
                          isNew: isNew,
                                  ),
                                ),
                               );
                              }
                            }
                          }
                        ,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Bottom curved section
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(resp.scaleWidth(50)),
                    topRight: Radius.circular(resp.scaleWidth(50)),
                  ),
                ),
                padding: EdgeInsets.all(resp.getHorizontalSpacing(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Instructions section
                    Column(
                      children: [
                        SizedBox(height: resp.getVerticalSpacing(20)),

                        Text(
                          'Get Started',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: resp.fontSize(24),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        SizedBox(height: resp.getVerticalSpacing(15)),

                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: resp.getHorizontalSpacing(20),
                          ),
                          child: Text(
                            'Scan the QR code to explore detailed information about this artefact, including its history, significance, and origin.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: resp.fontSize(14),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Bottom section with button
                    Column(
                      children: [
                        // Go/Retry button
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: EdgeInsets.only(
                              bottom: resp.getVerticalSpacing(20),
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                padding: EdgeInsets.symmetric(
                                  horizontal: resp.getHorizontalSpacing(20),
                                  vertical: resp.getVerticalSpacing(15),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: resp.getBorderRadius(12),
                                ),
                              ),
                              onPressed: () {
                                // Reset the scan if already scanned
                                if (_hasScanned) {
                                  setState(() {
                                    _hasScanned = false;
                                    _scanResult = "";
                                  });
                                }
                                // Force a restart of the scanner
                                controller.start();
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    _hasScanned ? 'Retry' : 'Go',
                                    style: TextStyle(
                                      fontSize: resp.fontSize(16),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: resp.getHorizontalSpacing(8)),
                                  Icon(
                                    _hasScanned ? Icons.refresh : Icons.arrow_forward,
                                    size: resp.iconSize(20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Home indicator
                        Container(
                          width: resp.scaleWidth(134),
                          height: resp.scaleHeight(5),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(resp.scaleWidth(100)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build circular buttons
  Widget _buildCircleButton(
      BuildContext context,
      IconData icon,
      VoidCallback onPressed,
      ResponsiveUtils resp,
      ) {
    return Container(
      width: resp.scaleWidth(48),
      height: resp.scaleWidth(48),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: resp.iconSize(24)),
        padding: EdgeInsets.zero,
        onPressed: onPressed,
      ),
    );
  }
}
