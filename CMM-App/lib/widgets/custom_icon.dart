import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIcon extends StatelessWidget {
  final String? assetName;
  final IconData? icon;
  final double size;
  final Color? color;

  const CustomIcon({
    super. key,
    this.assetName,
    this.icon,
    this.size = 24.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (assetName != null) {
      return SvgPicture.asset(
        assetName!,
        width: size,
        height: size,
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
      );
    } else if (icon != null) {
      return Icon(
        icon,
        size: size,
        color: color,
      );
    }
    return const SizedBox.shrink();
  }
}