import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:cheshire_military_museum_tour/models/medal_tracker.dart';
import 'artefact_screen.dart';

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
              // Curved bottom section
              Positioned(
                left: 0,
                top: 495,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 359,
                  decoration: const BoxDecoration(
                    color: Color(0xFF75775D),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                ),
              ),

              // App bar with title and navigation buttons
              Positioned(
                left: 11,
                top: 60,
                child: SizedBox(
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
                              // Settings action
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
                            'Scan QR',
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

              // QR Scanner
              Positioned(
                left: 73,
                top: 166,
                child: Container(
                  width: 247,
                  height: 273,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
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
                      style: const TextStyle(
                        fontSize: 16,
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
                  ),
                ),
              ),

              // Get Started title
              const Positioned(
                left: 79,
                top: 552,
                child: SizedBox(
                  width: 236,
                  height: 29,
                  child: Text(
                    'Get Started',
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

              // Description text
              const Positioned(
                left: 37,
                top: 597,
                child: SizedBox(
                  width: 319,
                  height: 66,
                  child: Text(
                    'Scan the QR code to explore detailed information about this artefact, including its history, significance, and origin.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),

              // Go button
              Positioned(
                left: 242,
                top: 759,
                child: Container(
                  width: 114,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
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
                      borderRadius: BorderRadius.circular(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _hasScanned ? 'Retry' : 'Go',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            _hasScanned ? Icons.refresh : Icons.arrow_forward,
                            size: 20,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Home indicator
              Positioned(
                left: 129,
                bottom: 6,
                child: Container(
                  width: 134,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
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