import 'package:flutter/material.dart';

class ZoomInOffset extends StatefulWidget {
  final Widget? child;
  final Duration? duration;
  final Duration? delay;
  final Function(AnimationController)? controller;
  final bool? manualTrigger;
  final bool? animate;
  final double? from;
  final Offset? offset;

  const ZoomInOffset({
    super.key,
    this.child,
    this.duration = const Duration(milliseconds: 500),
    this.delay = const Duration(milliseconds: 0),
    this.controller,
    this.manualTrigger = false,
    this.animate = true,
    this.offset,
    this.from = 1.0,
  });

  @override
  State<StatefulWidget> createState() => _ZoomInState();

}



class _ZoomInState extends State<ZoomInOffset>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> fade;
  late Animation<double> opacity;
  bool disposed = false;

  @override
  void dispose() async {
    disposed = true;
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);
    fade = Tween(begin: 0.0, end: widget.from)
        .animate(CurvedAnimation(curve: Curves.easeOut, parent: controller));

    opacity = Tween<double>(begin: 0.0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: const Interval(0, 0.65)));

    if (!widget.manualTrigger! && widget.animate!) {
      Future.delayed(widget.delay!, () {
        if (!disposed) {
          controller.forward();
        }
      });
    }

    if (widget.controller is Function) {
      widget.controller!(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate! && widget.delay!.inMilliseconds == 0) {
      controller.forward();
    }

    return AnimatedBuilder(
      animation: fade,
      builder: (BuildContext context, Widget? child) {
        return Transform.scale(
          origin: widget.offset,
          scale: fade.value,
          child: Opacity(
            opacity: opacity.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}
