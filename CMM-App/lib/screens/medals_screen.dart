import 'package:cheshire_military_museum_tour/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import '../models/medal_tracker.dart';
import '../widgets/navigation_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../data/messages.dart';

class MedalsScreen extends StatelessWidget {
  const MedalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scanned = MedalTracker().scannedCount;

    // Map each rank to its scan threshold and asset image
    final ranks = [
      {'label': 'Private', 'required': 1, 'asset': 'assets/icons/Bronze.svg'},
      {'label': 'Sergeant', 'required': 3, 'asset': 'assets/icons/Silver.svg'},
      {'label': 'Lieutenant', 'required': 5, 'asset': 'assets/icons/Gold.svg'},
      {'label': 'Marshal', 'required': 7, 'asset': 'assets/icons/platinum.svg'},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(titleText: 'Medals', context: context),
      body: Column(
        children: [
          // Military Rank Title
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Military Rank',
                //TODO Zwe change here:
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, fontFamily: 'Inter', color: Colors.black),
              ),
            ),
          ),

          // Medals row
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:
                ranks.map((rank) {
                  final isEarned = scanned >= (rank['required'] as int);
                  return Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 600),
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        child:
                            isEarned
                                ? Center(
                                  child: SvgPicture.asset(
                                    rank['asset'] as String,
                                    width: 40,
                                    // Smaller size to fit inside circle
                                    height: 40,
                                  ),
                                )
                                : const Icon(Icons.lock, color: Colors.black),
                      ),
                      SizedBox(height: 8),
                      Text(
                        rank['label'] as String,
                        //TODO Zwe change here:
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  );
                }).toList(),
          ),
          SizedBox(height: 25),

          // Message
          Text(
            getProgressMessage(scanned),
            textAlign: TextAlign.center,
            // TODO Zwe change here:
            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Spacer(flex: 10),
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset('lib/img/teddy/4-CharlieScout-A4-Noback.png', width: 300, height: 300),
          ),
        ],
      ),

      // Bottom Navigation
      bottomNavigationBar: const CustomNavigationBar(currentIndex: 3),
    );
  }
}
