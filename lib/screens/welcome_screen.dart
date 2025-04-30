import 'package:flutter/material.dart';
import 'explore_screen.dart';

void main() {
  runApp(const FigmaToCodeApp());
}

class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Museum App',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: const HomePage1LowFid(),
    );
  }
}

class HomePage1LowFid extends StatelessWidget {
  const HomePage1LowFid({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 393,
          height: 852,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              // Background curved section
              Positioned(
                left: 0,
                top: 495,
                child: Container(
                  width: 394,
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

              // Hero image from local asset
              Positioned(
                left: 43,
                top: 136,
                child: SizedBox(
                  width: 321,
                  height: 324,
                  child: Image.asset(
                    'lib/img/img.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Museum title
              const Positioned(
                left: 40,
                top: 552,
                child: SizedBox(
                  width: 313,
                  height: 85,
                  child: Text(
                    'The Cheshire Military Museum',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              // Museum description
              const Positioned(
                left: 37,
                top: 661,
                child: SizedBox(
                  width: 319,
                  height: 66,
                  child: Text(
                    'Begin your journey through four centuries of the military in Cheshire at the Cheshire Military Museum.',
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

              // "Go" Button
              Positioned(
                left: 242,
                top: 759,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    minimumSize: const Size(114, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    // Navigate to the Explore screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ExploreScreen()),
                    );
                  },
                  child: const Text(
                    'Go',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
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