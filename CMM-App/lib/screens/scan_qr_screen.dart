import 'package:cheshire_military_museum_tour/services/artefact_service.dart';
import 'package:cheshire_military_museum_tour/widgets/app_bar.dart';
import 'package:cheshire_military_museum_tour/widgets/bottom_info_card.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:cheshire_military_museum_tour/screens/artefact_detail_screen.dart';
import '../models/medal_tracker.dart';
import '../widgets/navigation_bar.dart';

class ScanQRScreen extends StatefulWidget {
  const ScanQRScreen({super.key});

  @override
  State<ScanQRScreen> createState() => _ScanQRScreenState();
}

class _ScanQRScreenState extends State<ScanQRScreen> {
  late final MobileScannerController controller;
  late final MedalTracker medalTracker;
  late final ArtefactService artefactService;
  bool isHandlingScan = false;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController();
    medalTracker = MedalTracker();
    artefactService = ArtefactService();
    isHandlingScan = false;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        context: context,
        titleText: 'Scan QR' ,
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // QR Scanner
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(40),
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
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
                          if (isHandlingScan) return;
                          controller.stop();
                          isHandlingScan = true;


                          final List<Barcode> barcodes = capture.barcodes;
                          final String? code = barcodes.first.rawValue;
                          if (code == null || code.isEmpty) {
                            isHandlingScan = false;
                            controller.start();
                            return;
                          }

                          bool isNew = medalTracker.checkIfNew(code) && await artefactService.artefactExistsInDatabase(code);
                          if (isNew) medalTracker.addScan(code);

                          if (!mounted) {
                            controller.start();
                            isHandlingScan = false;
                            return;
                          }

                          // Navigate to artefact detail screen
                          await Navigator.push(
                            context, //ignore: use_build_context_synchronously (checked above)
                            MaterialPageRoute(
                              builder:
                                  (context) => ArtefactDetailScreen(artefactId: code, isNew: isNew, fromScanner: true),
                            ),
                          );
                          isHandlingScan = false;
                          controller.start();
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