import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../style/colors.dart' as color;

class MyElevatedButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double height;
  final Gradient gradient;
  final VoidCallback? onPressed;
  final Widget child;

  const MyElevatedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.width,
    this.height = 45,
    this.padding,
    this.gradient = const LinearGradient(
        colors: [
          Color(0x990f17ad),
          Color(0xFF6985e8)
        ],
      begin: Alignment.bottomLeft,
      end: Alignment.centerRight,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(0);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
                offset: const Offset(5, 7),
                blurRadius: 10,
                color: color.AppColor.gradientSecond.withOpacity(0.3)
            )
          ]
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
          shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: borderRadius)),
          elevation: MaterialStateProperty.all<double>(0),
          overlayColor: MaterialStateProperty.all<Color>(Colors.indigo.withOpacity(0.4)),
          shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(padding ?? const EdgeInsets.all(0)),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
