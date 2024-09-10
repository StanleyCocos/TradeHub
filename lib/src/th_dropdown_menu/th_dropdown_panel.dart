import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'th_dropdown_menu.dart';
import 'th_dropdown_popup.dart';

typedef FutureParamCallback = void Function(Future<void> Function());

class THDropdownPanel extends StatefulWidget {
  const THDropdownPanel({
    Key? key,
    required this.initContentTop,
    required this.initContentBottom,
    required this.reverseHeight,
    required this.duration,
    required this.directionListenable,
    required this.colorAlphaListenable,
    required this.direction,
    required this.closeCallback,
    required this.onOpened,
    required this.child,
  }) : super(key: key);

  final double initContentTop;
  final double initContentBottom;
  final double reverseHeight;
  final Duration duration;
  final ValueNotifier<THDropdownPopupDirection> directionListenable;
  final ValueNotifier<bool> colorAlphaListenable;
  final THDropdownPopupDirection direction;
  final FutureParamCallback closeCallback;
  final VoidCallback onOpened;
  final Widget child;

  @override
  _THDropdownPanelState createState() => _THDropdownPanelState();
}

class _THDropdownPanelState extends State<THDropdownPanel> with SingleTickerProviderStateMixin {
  double? contentTop, contentBottom;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    widget.closeCallback(close);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PositionedTransition(
      rect: _getAnimation(),
      child: SingleChildScrollView(
        child: Builder(
          builder: (BuildContext context) {
            open(context);
            return widget.child;
          },
        ),
      ),
    );
  }

  void open(BuildContext itemContext) {
    if (contentBottom != null || contentTop != null) {
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var renderBox = itemContext.findRenderObject() as RenderBox;
      var size = renderBox.size;
      if (widget.directionListenable.value == THDropdownPopupDirection.auto) {
        // 比较展开方向（down）的高度能不能放下item，能将方向更新为down
        // 否则比较反方向（up）的高度是否大于down的方向，大于则将方向更新为up，否则保持为down
        if (widget.direction == THDropdownPopupDirection.down) {
          if (widget.initContentBottom >= size.height) {
            widget.directionListenable.value = THDropdownPopupDirection.down;
          } else {
            if (widget.reverseHeight > widget.initContentBottom) {
              widget.directionListenable.value = THDropdownPopupDirection.up;
            } else {
              widget.directionListenable.value = THDropdownPopupDirection.down;
            }
          }
        } else {
          if (widget.initContentTop >= size.height) {
            widget.directionListenable.value = THDropdownPopupDirection.up;
          } else {
            if (widget.reverseHeight > widget.initContentTop) {
              widget.directionListenable.value = THDropdownPopupDirection.down;
            } else {
              widget.directionListenable.value = THDropdownPopupDirection.up;
            }
          }
        }
        return;
      }
      if (widget.direction == THDropdownPopupDirection.down) {
        contentBottom = widget.initContentBottom - size.height;
      } else {
        contentTop = widget.initContentTop - size.height;
      }
      setState(() {});
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_controller.status == AnimationStatus.dismissed) {
          widget.colorAlphaListenable.value = true;
          _controller.forward().whenCompleteOrCancel(() {
            widget.onOpened();
          });
        }
      });
    });
  }

  Animation<RelativeRect> _getAnimation() {
    return RelativeRectTween(
      begin: RelativeRect.fromLTRB(0, widget.initContentTop, 0, widget.initContentBottom),
      end: RelativeRect.fromLTRB(0, contentTop ?? widget.initContentTop, 0, contentBottom ?? widget.initContentBottom),
    ).animate(_controller);
  }

  Future<void> close() {
    widget.colorAlphaListenable.value = false;
    return _controller.reverse();
  }
}
