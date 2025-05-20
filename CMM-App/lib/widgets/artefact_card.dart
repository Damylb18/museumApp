import 'package:flutter/material.dart';
import '../models/artefact.dart';
import '../screens/artefact_detail_screen.dart';
import '../utils/responsive_utils.dart';

class ArtefactWidget extends StatelessWidget {
  final Artefact artefact;
  final ResponsiveUtils resp;

  const ArtefactWidget({
    super.key,
    required this.artefact,
    required this.resp,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArtefactDetailScreen(
              artefactId: artefact.id,
              isNew: false,
              fromScanner: false,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image or placeholder
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: resp.getBorderRadius(8),
              ),
              clipBehavior: Clip.hardEdge,
              child: artefact.imageFile != null
                  ? Image.file(
                artefact.imageFile!,
                fit: BoxFit.cover,
                width: double.infinity,
              )
                  : const Center(
                child: Icon(
                  Icons.image,
                  color: Colors.white54,
                  size: 40,
                ),
              ),
            ),
          ),

          // Name
          Padding(
            padding: EdgeInsets.only(top: resp.getVerticalSpacing(4)),
            child: Text(
              artefact.name,
              style: TextStyle(
                fontSize: resp.fontSize(14),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
