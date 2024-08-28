import 'package:flutter/material.dart';

import 'popup_route.dart';

enum THPopupOrigin {
  /// 左上
  lt,

  /// 右上
  rt,

  /// 左下
  lb,

  /// 右下
  rb,
}

class THPopup extends StatefulWidget {
  final Widget child;
  final Widget Function(BuildContext context) builder;
  final Offset offset;
  final THPopupOrigin origin;
  final bool dismissible;
  final Color? color;

  const THPopup({
    Key? key,
    required this.child,
    required this.builder,
    this.offset = Offset.zero,
    this.origin = THPopupOrigin.lb,
    this.dismissible = false,
    this.color,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _STPopupState();
}

class _STPopupState extends State<THPopup> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child: widget.child,
    );
  }
}

extension _Action on _STPopupState {
  void _onTap() {
    RenderObject? renderBox = context.findRenderObject();
    Offset position = Offset.zero;
    if (renderBox != null && renderBox is RenderBox) {
      position = renderBox.localToGlobal(Offset.zero);
      switch (widget.origin) {
        case THPopupOrigin.lt:
          position = Offset(position.dx, position.dy);
          break;
        case THPopupOrigin.rt:
          position = Offset(position.dx + renderBox.size.width, position.dy);
          break;
        case THPopupOrigin.lb:
          position = Offset(position.dx, position.dy + renderBox.size.height);
          break;
        case THPopupOrigin.rb:
          position = Offset(position.dx + renderBox.size.width, position.dy + renderBox.size.height);
          break;
      }
    }
    position = Offset(
      position.dx + widget.offset.dx,
      position.dy + widget.offset.dy,
    );
    Navigator.push(
      context,
      THPopRoute(
        color: widget.color,
        dismissible: widget.dismissible,
        child: widget.builder.call(context),
        position: position,
      ),
    );
  }
}
