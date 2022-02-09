import 'package:flutter/material.dart';
import '../style/colors.dart' as color;

class MyElevatedButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double height;
  final VoidCallback? onPressed;
  final Widget child;
  final bool disable;
  final String mode;

  const MyElevatedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    required this.disable,
    required this.mode,
    this.borderRadius,
    this.width,
    this.height = 45,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(0);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: disable ? mode == 'dark' ? color.AppColorDarkMode.primary : color.AppColorLightMode.primary
              :
          mode == 'dark' ? color.AppColorDarkMode.secondary : color.AppColorLightMode.secondary,
          borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
          shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: borderRadius)),
          elevation: MaterialStateProperty.all<double>(0),
          overlayColor: disable ?
          MaterialStateProperty.all<Color>(Colors.white.withOpacity(0))
              :
          MaterialStateProperty.all<Color>(mode == "dark" ? color.AppColorDarkMode.secondaryText.withOpacity(0.25) : color.AppColorLightMode.secondaryText.withOpacity(0.25)),
          shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(padding ?? const EdgeInsets.all(0)),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
