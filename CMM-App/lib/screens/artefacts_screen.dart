import 'package:cheshire_military_museum_tour/services/artefact_service.dart';
import 'package:flutter/material.dart';
import '../models/artefact.dart';
import '../models/medal_tracker.dart';
import '../utils/responsive_utils.dart';
import '../widgets/artefact_card.dart';
import '../widgets/circle_button.dart';
import '../widgets/custom_icon.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/sidebar_menu.dart';

class ArtefactsScreen extends StatefulWidget {
  const ArtefactsScreen({super.key});

  @override
  State<ArtefactsScreen> createState() => _ArtefactsScreenState();
}

class _ArtefactsScreenState extends State<ArtefactsScreen> {
  final ArtefactService artefactService = ArtefactService();
  late final List<String> artefactIds;
  late final List<Future<Artefact?>> artefactFutures;
  final resp = ResponsiveUtils.instance;

  @override
  void initState() {
    super.initState();
    artefactIds = MedalTracker().scannedArtefacts.toList();

    artefactFutures =
        artefactIds.map((id) =>
            artefactService
                .getArtefactById(id))
            .toList();
  }

  @override
  Widget build(BuildContext context) {
    resp.init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Artefacts',
          style: TextStyle(color: Colors.black, fontSize: resp.fontSize(24), fontWeight: FontWeight.w700),
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: resp.getHorizontalSpacing(8)),
          child: CircleButton(
            icon: Icons.more_vert,
            onPressed: () {
              showDialog(
                context: context,
                barrierColor: Colors.black.withValues(alpha: 0.5),
                builder: (context) => const SideBarMenu(),
              ); // Menu action
            },
            backgroundColor: Theme
                .of(context)
                .primaryColor,
          ),
        ),
        leadingWidth: resp.scaleWidth(64),
      ),
      body: SafeArea(child: artefactIds.isEmpty ? _buildEmptyState() : _buildArtifactGrid(context)),
      bottomNavigationBar: const CustomNavigationBar(currentIndex: 2),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: EdgeInsets.only(top: resp.getVerticalSpacing(20)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIcon(assetName: 'assets/icons/search.svg', size: resp.iconSize(40), color: Colors.grey),
            SizedBox(height: resp.getVerticalSpacing(16)),
            Text(
              'No artefacts collected yet',
              style: TextStyle(fontSize: resp.fontSize(18), fontWeight: FontWeight.w500, color: Colors.grey[700]),
            ),
            SizedBox(height: resp.getVerticalSpacing(8)),
            Text(
              'Scan QR codes at the museum to collect artefacts',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: resp.fontSize(14), color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArtifactGrid(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: resp.getVerticalSpacing(20),
        left: resp.getHorizontalSpacing(20),
        right: resp.getHorizontalSpacing(20),
      ),
      child: GridView.builder(
        itemCount: artefactFutures.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: resp.getHorizontalSpacing(16),
          mainAxisSpacing: resp.getVerticalSpacing(16),
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          return FutureBuilder<Artefact?>(
            future: artefactFutures[index],
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error loading artefact',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                );
              } else if (snapshot.hasData) {
                return ArtefactWidget(artefact: snapshot.data!, resp: resp);
              } else {
              return const Center(child: Text('Artefact not found'));
              }
            },
          );
        },
      ),
    );
  }
}