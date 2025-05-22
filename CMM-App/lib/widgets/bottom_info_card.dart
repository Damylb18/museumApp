import 'package:flutter/material.dart';

class BottomInfoCard extends StatelessWidget {
  final String? title;
  final String? content;
  final String? warning;

  const BottomInfoCard({super.key, required this.title, required this.content, this.warning});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
      ),
      padding: EdgeInsets.only(top: 25, bottom: 10),
      child: Column(
        children: [
          // Add warning prompt, generally to indicate artefact already scanned.
          if (warning != null)
            Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Text(
                warning!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.yellowAccent),
              ),
            ),

          // Title
          Text(
            title ?? '',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),

          // Content
          SizedBox(height: 10,),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Text(
                      content ?? '',
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
