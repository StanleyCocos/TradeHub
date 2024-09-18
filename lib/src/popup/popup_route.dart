import 'dart:ui';

import 'package:flutter/material.dart';

class THPopRoute extends PopupRoute {
  final Color? color;
  final bool dismissible;
  final String? label;
  final Duration duration;
  final Widget child;
  final Offset position;

  THPopRoute({
    required this.child,
    this.color,
    this.dismissible = false,
    this.label,
    this.position = Offset.zero,
    this.duration = const Duration(milliseconds: 300),
    RouteSettings? settings,
    ImageFilter? filter,
    TraversalEdgeBehavior? traversalEdgeBehavior,
  }) : super(
          settings: settings,
          filter: filter,
          traversalEdgeBehavior: traversalEdgeBehavior,
        );

  @override
  Color? get barrierColor => color;

  @override
  bool get barrierDismissible => dismissible;

  @override
  String? get barrierLabel => label;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Stack(
      children: [
        GestureDetector(
          onTap: !dismissible ? () => Navigator.pop(context) : null,
          child: Container(
            color: Colors.transparent,
          ),
        ),
        Positioned(left: position.dx, top: position.dy, child: child),
      ],
    );
  }

  @override
  Duration get transitionDuration => duration;
}
