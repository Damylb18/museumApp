import 'dart:io'; // Used to verify real internet access (not just connectivity)
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // For opening URLs in browser
import 'dart:async'; // For handling TimeoutException

class UrlUtils {
  // Attempts to open an external URL after checking for internet access
  static Future<void> openExternalUrl(BuildContext context, String url) async {
    final uri = Uri.parse(url); // Parse the URL into a Uri object

    // Check if there is actual internet access (DNS lookup)
    if (!await _hasInternet()) {
      _showErrorDialog(context, 'No Internet', 'Please check your internet connection.');
      return;
    }

    try {
      // Try launching the URL with a 10-second timeout
      await launchUrl(uri, mode: LaunchMode.externalApplication)
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException('The page took too long to load.');
      });
    } on TimeoutException {
      _showErrorDialog(context, 'Timeout', 'The page took too long to load.');
    } catch (e) {
      _showErrorDialog(context, 'Error', 'Could not open the link.');
    }
  }

  // Performs a DNS lookup to verify internet access
  static Future<bool> _hasInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  // Displays an error dialog with a given title and message
  static void _showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Dismisses the dialog
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
