import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      ),
      home: const FigmaToCodeApp(),
    );
  }
}
