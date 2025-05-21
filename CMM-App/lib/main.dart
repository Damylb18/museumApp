// lib/main.dart
import 'dart:io';
import 'package:cheshire_military_museum_tour/models/medal_tracker.dart';
import 'package:cheshire_military_museum_tour/services/artefact_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'screens/welcome_screen.dart';
import 'utils/responsive_utils.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var artefactService = ArtefactService();
  await MedalTracker().initialize(artefactService);

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // Ensure WebView works properly on iOS
  if (Platform.isIOS) {
    WebViewPlatform.instance = WebKitWebViewPlatform();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cheshire Military Museum Tour',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        useMaterial3: true,
        fontFamily: 'Inter',

        // Define app-wide color scheme
        colorScheme: const ColorScheme.light(
          // Main colors
          primary: Color(0xFF595B41),       // Main green color
          secondary: Color(0xFFDCCFBB),     // Light beige color
          tertiary: Color(0xFFB82F39),      // Red accent color
          surface: Colors.white,            // Card surfaces
          // Text colors on backgrounds
          onPrimary: Colors.white,          // Text on primary color
          onSecondary: Colors.black,        // Text on secondary color
          onTertiary: Colors.white,         // Text on tertiary color
          onSurface: Colors.black,          // Text on surface
        ),

        // Define text styles with original font sizes
        textTheme: const TextTheme(
          // Large display text (Welcome! heading)
          displayLarge: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Inter',
          ),
          // Medium display text (Screen titles)
          displayMedium: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Inter',
          ),
          // Small display text (Bottom card titles)
          displaySmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontFamily: 'Inter',
          ),
          // Medium headings (AppBar titles)
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontFamily: 'Inter',
          ),
          // Large titles (Card titles, section headers)
          titleLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontFamily: 'Inter',
          ),
          // Large body text (Primary content)
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontFamily: 'Inter',
          ),
          // Medium body text (Secondary content)
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontFamily: 'Inter',
          ),
          // Small body text (Captions, small info)
          bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontFamily: 'Inter',
          ),
        ),

        // Define button styles
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF595B41), // Primary color
            foregroundColor: Colors.white,            // Text color
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      builder: (context, child) {
        // Initialize ResponsiveUtils with the current context
        ResponsiveUtils.instance.init(context);

        // Return the child with the initialized ResponsiveUtils
        return child!;
      },
      home: const WelcomeScreen(),
    );
  }
}