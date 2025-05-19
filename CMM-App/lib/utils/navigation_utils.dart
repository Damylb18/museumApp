import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../screens/webview_screen.dart'; // Update path as needed

class NavigationUtils {
  // Open a web page if online
  static Future<void> openWebPage(BuildContext context, String title, String url) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      _showErrorDialog(context, 'No Internet', 'Please check your internet connection.');
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WebPageScreen(title: title, url: url),
      ),
    );
  }

  // Show error dialog
  static void _showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}