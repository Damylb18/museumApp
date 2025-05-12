import 'package:flutter/material.dart';
import 'package:cheshire_military_museum_tour/utils/responsive_utils.dart';

class CircleButton extends StatelessWidget {
  final IconData? icon;
  final Widget? customIcon;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color iconColor;

  /// Creates a circular button with either an icon or a custom widget
  ///
  /// You must provide either [icon] or [customIcon], but not both.
  const CircleButton({
    super.key,
    this.icon,
    this.customIcon,
    required this.onPressed,
    this.backgroundColor,
    this.iconColor = Colors.white,
  }) : assert(
  (icon != null || customIcon != null) && !(icon != null && customIcon != null),
  'Either provide an icon or a customIcon, but not both or neither',
  );

  @override
  Widget build(BuildContext context) {
    final resp = ResponsiveUtils.instance;

    // Fixed size based on your existing design
    return Container(
      width: resp.scaleWidth(48),
      height: resp.scaleWidth(48),
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).colorScheme.primary,
        shape: BoxShape.circle,
      ),
      child: customIcon != null
          ? Center(child: customIcon)
          : IconButton(
        icon: Icon(
          icon,
          color: iconColor,
          size: resp.iconSize(24),
        ),
        padding: EdgeInsets.zero,
        onPressed: onPressed,
      ),
    );
  }
}