import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart'; // For checking network connectivity
import '../screens/webview_screen.dart'; // Custom screen that displays web content

class NavigationUtils {
  // Opens an in-app web page only if internet is available
  static Future<void> openWebPage(BuildContext context, String title, String url) async {
    var connectivityResult = await Connectivity().checkConnectivity(); // Check network status

    if (connectivityResult == ConnectivityResult.none) {
      // Show error if no internet connection
      _showErrorDialog(context, 'No Internet', 'Please check your internet connection.');
      return;
    }

    // Navigate to WebPageScreen if connected
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WebPageScreen(title: title, url: url),
      ),
    );
  }

  // Displays an error dialog with a title and message
  static void _showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Close the dialog
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
