import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class THButton extends StatelessWidget {
  const THButton.high({
    Key? key,
    this.text = '',
    this.borderRadius = 100,
    this.padding,
    this.backgroundColor = const Color(0xFFFF6600),
    this.style = const TextStyle(fontSize: 16, color: Color(0xFFFFFFFF)),
    this.onTap,
    this.border,
  }) : super(key: key);

  const THButton.normal({
    Key? key,
    this.text = '',
    this.borderRadius = 100,
    this.padding ,
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.style = const TextStyle(fontSize: 16, color: Color(0xFF333333)),
    this.border,
    this.onTap,
  }) : super(key: key);

  const THButton({
    Key? key,
    this.text = '',
    this.borderRadius = 0.0,
    this.padding,
    this.border,
    this.backgroundColor,
    this.onTap,
    this.style,
  }) : super(key: key);

  final String text;
  final double borderRadius;
  final EdgeInsets? padding;
  final Border? border;
  final Color? backgroundColor;
  final TextStyle? style;
  final GestureTapCallback? onTap;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: border,
        ),
        // alignment: padding == null ? Alignment.center : null,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          text,
          style: style,
          textAlign: TextAlign.center,
          // strutStyle: const StrutStyle(
          //   leading: 0,
          //   height: 1.1,
          //   forceStrutHeight: true,
          // ),
        ),
      ),
    );
  }
}
