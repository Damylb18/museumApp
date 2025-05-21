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
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(height: 15),
          if (warning != null)
            Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Text(
                warning!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.yellow, fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),

          Text(
            title ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 34, fontFamily: 'Inter', fontWeight: FontWeight.w700),
          ),

          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Text(
                content ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Inter', fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
