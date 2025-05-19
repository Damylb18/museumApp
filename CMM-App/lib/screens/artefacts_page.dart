import 'package:flutter/material.dart';
import '../models/medal_tracker.dart';
import '../utils/responsive_utils.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/circle_button.dart';
import 'package:cheshire_military_museum_tour/widgets/custom_icon.dart';
import 'artefact_screen.dart';

class ArtefactsScreen extends StatelessWidget {
  const ArtefactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = ResponsiveUtils.instance;
    resp.init(context);
    final medalTracker = MedalTracker();

    // Get the list of artifact IDs from the medal tracker
    final List<String> artifactIds = medalTracker.scannedArtefacts.toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Artefacts',
          style: TextStyle(
            color: Colors.black,
            fontSize: resp.fontSize(24),
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: resp.getHorizontalSpacing(8)),
          child: CircleButton(
            icon: Icons.more_vert,
            onPressed: () {
              // Menu action
            },
            backgroundColor: const Color(0xFF72745D),
          ),
        ),
        leadingWidth: resp.scaleWidth(64),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: resp.getHorizontalSpacing(20),
                vertical: resp.getVerticalSpacing(16),
              ),
              child: Container(
                height: resp.scaleHeight(40),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: resp.getBorderRadius(20),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search here',
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(resp.getHorizontalSpacing(8)),
                      child: CustomIcon(
                        assetName: 'assets/icons/search.svg',  // Replace with your SVG path
                        size: resp.iconSize(18),
                        color: Colors.grey[600],
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: resp.getVerticalSpacing(10),
                    ),
                  ),
                ),
              ),
            ),

            // Section title
            Padding(
              padding: EdgeInsets.only(
                left: resp.getHorizontalSpacing(20),
                bottom: resp.getVerticalSpacing(16),
              ),
              child: Text(
                'Collected Artefacts',
                style: TextStyle(
                  fontSize: resp.fontSize(20),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Artifact grid
            Expanded(
              child: artifactIds.isEmpty
                  ? _buildEmptyState(resp)
                  : _buildArtifactGrid(context, artifactIds, resp),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(
        currentIndex: 2, // Artifacts tab
      ),
    );
  }

  Widget _buildEmptyState(ResponsiveUtils resp) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIcon(
            assetName: 'assets/icons/search.svg',
            size: resp.iconSize(40),
            color: Colors.grey,
          ),
          SizedBox(height: resp.getVerticalSpacing(16)),
          Text(
            'No artefacts collected yet',
            style: TextStyle(
              fontSize: resp.fontSize(18),
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: resp.getVerticalSpacing(8)),
          Text(
            'Scan QR codes at the museum to collect artefacts',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: resp.fontSize(14),
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArtifactGrid(BuildContext context, List<String> artifactIds, ResponsiveUtils resp) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: resp.getHorizontalSpacing(20)),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: resp.getHorizontalSpacing(16),
          mainAxisSpacing: resp.getVerticalSpacing(16),
          childAspectRatio: 1,
        ),
        itemCount: artifactIds.length,
        itemBuilder: (context, index) {
          final artifactId = artifactIds[index];
          return _buildArtifactCard(context, artifactId, resp);
        },
      ),
    );
  }

  Widget _buildArtifactCard(BuildContext context, String artifactId, ResponsiveUtils resp) {
    return GestureDetector(
      onTap: () {
        // Navigate to artifact detail screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArtefactDetailScreen(
              artefactId: artifactId,
              isNew: false, // It's not new since we're viewing from collection
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Artifact image container
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: resp.getBorderRadius(8),
              ),
              // This would be replaced with the actual image from the API
              child: const Center(
                child: Icon(
                  Icons.image,
                  color: Colors.white54,
                  size: 40,
                ),
              ),
            ),
          ),

          // Artifact name
          Padding(
            padding: EdgeInsets.only(top: resp.getVerticalSpacing(4)),
            child: Text(
              'Artefact Name',
              style: TextStyle(
                fontSize: resp.fontSize(14),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Date scanned
          Text(
            'Dated',
            style: TextStyle(
              fontSize: resp.fontSize(12),
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}