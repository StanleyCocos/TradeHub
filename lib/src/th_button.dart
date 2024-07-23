import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class _THBtn extends StatelessWidget {

  final Widget? child;
  final String text;
  final double borderRadius;
  final EdgeInsets? padding;
  final Border? border;
  final Color? backgroundColor;
  final TextStyle? style;
  final GestureTapCallback? onTap;
  final double? height;

  const _THBtn({
    Key? key,
    this.text = '',
    this.borderRadius = 0.0,
    this.padding,
    this.border,
    this.backgroundColor,
    this.onTap,
    this.style,
    this.child,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class THButton extends _THBtn {
  const THButton.high({
    super.key,
    super.text = '',
    super.height,
    super.borderRadius = 100,
    super.padding,
    super.backgroundColor = const Color(0xFFFF6600),
    super.style = const TextStyle(fontSize: 16, color: Color(0xFFFFFFFF)),
    super.onTap,
    super.border,
  });

  const THButton.normal({
    Key? key,
    super.text = '',
    super.height,
    super.borderRadius = 100,
    super.padding,
    super.backgroundColor = const Color(0xFFFFFFFF),
    super.style = const TextStyle(fontSize: 16, color: Color(0xFF333333)),
    super.border,
    super.onTap,
  }) : super(key: key);


  const THButton.custom({
    super.key,
    super.borderRadius = 100,
    super.padding,
    super.height,
    super.backgroundColor = const Color(0xFFFFFFFF),
    super.style = const TextStyle(fontSize: 16, color: Color(0xFF333333)),
    super.border,
    super.onTap,
    super.child,
  });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: border,
        ),
        alignment: height != null ? Alignment.center : null,
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: child ??
            Text(
              text,
              style: style,
              textAlign: TextAlign.center,
              strutStyle: const StrutStyle(
                leading: 0,
                height: 1.1,
                forceStrutHeight: true,
              ),
            ),
      ),
    );
  }
}
