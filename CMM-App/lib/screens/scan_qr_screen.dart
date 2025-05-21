import 'package:cheshire_military_museum_tour/widgets/bottom_info_card.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:cheshire_military_museum_tour/utils/responsive_utils.dart';
import 'package:cheshire_military_museum_tour/screens/artefact_detail_screen.dart';
import '../models/medal_tracker.dart';
import '../widgets/circle_button.dart';
import '../widgets/navigation_bar.dart';

class ScanQRScreen extends StatefulWidget {
  const ScanQRScreen({super.key});

  @override
  State<ScanQRScreen> createState() => _ScanQRScreenState();
}

class _ScanQRScreenState extends State<ScanQRScreen> {
  late final MobileScannerController controller;
  late final MedalTracker medalTracker;
  bool isHandlingScan = false;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController();
    medalTracker = MedalTracker();
    isHandlingScan = false;
  }

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
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        // Center the title
        title: Text(
          'Scan QR',
          style: TextStyle(
            color: Colors.black,
            fontSize: resp.fontSize(24),
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: resp.getHorizontalSpacing(8)),
          child: CircleButton(
            icon: Icons.arrow_back,
            onPressed: () => Navigator.pop(context),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ),
        leadingWidth: resp.scaleWidth(64),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // QR Scanner
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(resp.getHorizontalSpacing(65)),
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1.0,
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
                      child: MobileScanner(
                        controller: controller,
                        onDetect: (capture) async {
                          controller.stop();
                          if (isHandlingScan) return;
                          isHandlingScan = true;

                          final List<Barcode> barcodes = capture.barcodes;
                          final String? code = barcodes.first.rawValue;
                          if (code == null || code.isEmpty) return;

                          bool isNew = medalTracker.checkIfNew(code);
                          if (isNew) medalTracker.addScan(code);

                          // Navigate to artefact detail screen
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => ArtefactDetailScreen(artefactId: code, isNew: isNew, fromScanner: true),
                            ),
                          );
                          isHandlingScan = false;
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Bottom curved section
            Expanded(
              flex: 3,
              // Instructions section
              child: BottomInfoCard(
                title: 'Get Started',
                content:
                    'Scan the QR code to explore detailed information about this artefact, including its history, significance, and origin.',
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(currentIndex: 1),
    );
  }
}