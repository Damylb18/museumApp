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

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Ensure WebView works properly on iOS
  if (Platform.isIOS) {
    WebViewPlatform.instance = WebKitWebViewPlatform();
  }

  runApp(const MyApp());
}

// (Flutter, n.d.-a)
// Flutter. (n.d.-a). Update the UI based on orientation. Flutter Documentation. https://docs.flutter.dev/cookbook/design/orientation
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
        // Define app-wide text themes
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          displayMedium: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          displaySmall: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          headlineMedium: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          titleLarge: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          bodyLarge: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          bodyMedium: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
        // Define app-wide color scheme
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF75775D),
          primary: const Color(0xFF595B41),
          secondary: const Color(0xFFDCCFBB),
          tertiary: const Color(0xFFB82F39),
          surface: Colors.white,
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