import 'package:flutter/widgets.dart';
import 'package:trade_hub/src/th_dashed.dart';
import 'package:trade_hub/src/util/color_ext.dart';

/// 分割线
class THDivider extends StatelessWidget {
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final bool isDashed;

  /// 方向,竖直虚线必须传
  final Axis direction;

  const THDivider({
    Key? key,
    this.height,
    this.width,
    this.margin,
    this.color,
    this.isDashed = false,
    this.direction = Axis.horizontal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isDashed) {
      return Container(
        width: width,
        margin: margin,
        child: THDashed(
          width: width,
          height: height,
          color: color ?? THColor.grayE7E7E7,
          direction: direction,
        ),
      );
    } else {
      return Container(
        width: width,
        height: height ?? 1,
        margin: margin,
        color: color ?? THColor.grayE7E7E7,
      );
    }
  }
}
