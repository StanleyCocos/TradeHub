import 'package:flutter/material.dart';

/// create at: 2023-12-22:17:25
/// describe：
/// author: 10456

class THPopupItem extends StatelessWidget {
  final Widget child;
  final GestureTapCallback? onTap;

  const THPopupItem({
    Key? key,
    required this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
        onTap?.call();
      },
      child: child,
    );
  }
}
