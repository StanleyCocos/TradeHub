import 'package:flutter/material.dart';

class THBadge extends StatelessWidget {
  final int max;
  final int number;
  final Widget child;
  final double offset;

  const THBadge({
    Key? key,
    required this.child,
    this.max = 99,
    this.number = 0,
    this.offset = -10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(offset >= 0 ? 0: offset.abs()),
          child: child,
        ),
        _badge,
      ],
    );
  }

  Widget get _badge {
    if (number == 0) return const SizedBox.shrink();
    return Positioned(
      right: offset > 0 ? offset : 0,
      top: offset > 0 ? offset : 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFFF596B),
          borderRadius: BorderRadius.circular(8),
        ),
        constraints: const BoxConstraints(
          minWidth: 16,
          minHeight: 16,
        ),
        child: Text(
          number > max ? '$max+' : '$number',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
