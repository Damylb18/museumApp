import 'package:cheshire_military_museum_tour/widgets/sidebar_menu.dart';
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
            icon: Icons.more_vert,
            onPressed: () {
              showDialog(
                context: context,
                barrierColor: Colors.black.withValues(alpha: 0.5),
                builder: (context) => const SideBarMenu(),
              ); // Menu action
            },
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ),
        leadingWidth: 64,
      );
}
