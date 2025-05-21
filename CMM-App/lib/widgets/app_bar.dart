import 'package:flutter/material.dart';

import 'circle_button.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({super.key, super.title, required BuildContext context})
    : super(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 8),
          child: CircleButton(
            icon: Icons.arrow_back,
            onPressed: () => Navigator.pop(context),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ),
        leadingWidth: 64,
      );
}