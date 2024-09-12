import 'package:flutter/material.dart';
import 'package:trade_hub/src/util/color_ext.dart';
import 'package:trade_hub/trade_hub.dart';

import 'th_tag_styles.dart';

/// 展示型标签组件，仅展示，内部不可更改自身状态
/// 支持样式：方形/圆角/半圆/带关闭图标
///
class THTag extends StatelessWidget {
  const THTag(this.text,
      {this.icon,
      this.iconWidget,
      this.textColor,
      this.backgroundColor,
      this.font,
      this.fontWeight,
      this.style,
      this.border,
      this.borderColor,
      this.borderRadius,
      this.size = THTagSize.medium,
      this.padding,
      this.forceVerticalCenter = true,
      this.shape = THTagShape.square,
      this.needCloseIcon = false,
      this.onCloseTap,
      this.overflow,
      Key? key})
      : super(key: key);

  /// 标签内容
  final String text;

  /// 图标内容，可随状态改变颜色
  final IconData? icon;

  /// 自定义图标内容，需自处理颜色
  final Widget? iconWidget;

  /// 文字颜色, 优先级高于style的textColor
  final Color? textColor;

  /// 背景颜色, 优先级高于style的backgroundColor
  final Color? backgroundColor;

  /// 字体尺寸, 优先级高于style的font
  final Font? font;

  /// 字体粗细, 优先级高于style的fontWeight
  final FontWeight? fontWeight;

  /// 线框粗细, 优先级高于style的border
  final double? border;

  /// 边框颜色, 优先级高于style的borderColor
  final Color? borderColor;

  /// 圆角, 优先级高于style的borderRadius
  final BorderRadiusGeometry? borderRadius;

  /// 标签样式
  final THTagStyle? style;

  /// 标签大小
  final THTagSize size;

  /// 自定义模式下的间距
  final EdgeInsets? padding;

  /// 是否强制中文文字居中
  final bool forceVerticalCenter;

  /// 标签形状
  final THTagShape shape;

  /// 关闭图标
  final bool needCloseIcon;

  /// 文字溢出处理
  final TextOverflow? overflow;

  /// 关闭图标点击事件
  final GestureTapCallback? onCloseTap;

  @override
  Widget build(BuildContext context) {
    var innerStyle = _getInnerStyle(context);

    Widget child = THText(
      text,
      overflow: overflow,
      forceVerticalCenter: forceVerticalCenter,
      textColor: textColor ?? innerStyle.getTextColor,
      font: font ?? innerStyle.font ?? _getFont(context),
      fontWeight: fontWeight ?? innerStyle.fontWeight,
    );

    var innerIcon = getIcon(innerStyle);
    if (innerIcon != null || needCloseIcon) {
      var children = <Widget>[];
      if (innerIcon != null) {
        children.add(Container(
          margin: const EdgeInsets.only(right: 4),
          width: 14,
          height: 14,
          child: innerIcon,
        ));
      }
      children.add(child);
      if (needCloseIcon) {
        children.add(GestureDetector(
          onTap: onCloseTap,
          child: Container(
            margin: const EdgeInsets.only(left: 4),
            child: Icon(
              Icons.close_rounded,
              color: THColor.black66000000,
              size: 14,
            ),
          ),
        ));
      }
      child = Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    }

    return Container(
      padding: padding ?? _getPadding(border ?? innerStyle.border),
      decoration: BoxDecoration(
          color: backgroundColor ?? innerStyle.getBackgroundColor,
          border: Border.all(
              width: border ?? innerStyle.border,
              color: borderColor ?? innerStyle.getBorderColor),
          borderRadius: getBorderRadius(innerStyle)),
      child: child,
    );
  }

  BorderRadiusGeometry? getBorderRadius(THTagStyle innerStyle) {
    if (borderRadius != null) {
      return borderRadius;
    }
    if (innerStyle.getBorderRadius != null) {
      return innerStyle.getBorderRadius;
    }
    BorderRadiusGeometry tempBorderRadius = BorderRadius.circular(5);
    switch (shape) {
      case THTagShape.square:
        tempBorderRadius = BorderRadius.circular(5);
        break;
      case THTagShape.round:
        tempBorderRadius = BorderRadius.circular(9999);
        break;
      case THTagShape.rightRound:
        tempBorderRadius = const BorderRadius.only(
            topRight: Radius.circular(9999),
            bottomRight: Radius.circular(9999));
        break;
      case THTagShape.leftRound:
        tempBorderRadius = const BorderRadius.only(
            topLeft: Radius.circular(9999),
            bottomLeft: Radius.circular(9999));
        break;
    }
    return tempBorderRadius;
  }

  Widget? getIcon(THTagStyle innerStyle) {
    if (iconWidget != null) {
      return iconWidget;
    }
    if (icon != null) {
      return RichText(
        overflow: TextOverflow.visible,
        text: TextSpan(
          text: String.fromCharCode(icon!.codePoint),
          style: TextStyle(
            inherit: false,
            color: textColor ?? innerStyle.textColor,
            height: 1,
            fontSize: _getIconSize(),
            fontFamily: icon!.fontFamily,
            package: icon!.fontPackage,
          ),
        ),
      );
    }
    return null;
  }

  THTagStyle _getInnerStyle(BuildContext context) {
    if (style != null) {
      return style!;
    }
    return THTagStyle();
  }

  Font? _getFont(BuildContext context) {
    switch (size) {
      case THTagSize.extraLarge:
        return Font(size: 18, lineHeight: 26);
      case THTagSize.large:
        return Font(size: 14, lineHeight: 22);
      case THTagSize.small:
        return Font(size: 10, lineHeight: 16);
      default:
        return Font(size: 12, lineHeight: 20);
    }
  }

  /// 计算padding，需去除描边的宽对，对内描边
  EdgeInsets _getPadding(double border) {
    var hPadding = 0.0;
    var vPadding = 0.0;
    switch (size) {
      case THTagSize.extraLarge:
        hPadding = 16;
        vPadding = 9;
        break;
      case THTagSize.large:
        hPadding = 8;
        vPadding = 3;
        break;
      case THTagSize.medium:
        hPadding = 8;
        vPadding = 2;
        break;
      case THTagSize.small:
        hPadding = 6;
        vPadding = 2;
        break;
      default:
        return EdgeInsets.zero;
    }
    if (hPadding >= border) {
      hPadding = hPadding - border;
    } else {
      hPadding = 0;
    }
    if (vPadding >= border) {
      vPadding = vPadding - border;
    } else {
      vPadding = 0;
    }
    return EdgeInsets.only(
        left: hPadding, right: hPadding, top: vPadding, bottom: vPadding);
  }

  double _getIconSize() {
    switch (size) {
      case THTagSize.extraLarge:
        return 16;
      case THTagSize.large:
        return 16;
      case THTagSize.medium:
        return 14;
      case THTagSize.small:
        return 12;
      default:
        return 14;
    }
  }
}
