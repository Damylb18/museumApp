import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

class UrlUtils {
  // Open external URL with connectivity and timeout check
  static Future<void> openExternalUrl(BuildContext context, String url) async {
    final uri = Uri.parse(url);

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      _showErrorDialog(context, 'No Internet', 'Please check your internet connection.');
      return;
    }

    try {
      // Launch URL with 10 sec timeout
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
