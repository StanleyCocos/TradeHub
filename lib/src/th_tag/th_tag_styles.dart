import 'package:flutter/material.dart';
import 'package:trade_hub/src/util/color_ext.dart';
import 'package:trade_hub/trade_hub.dart';

/// 标签尺寸
enum THTagSize { extraLarge, large, medium, small, custom }

/// 标签形状
enum THTagShape { square, round, leftRound, rightRound }

/// 标签样式
class THTagStyle {
  THTagStyle(
      {this.context,
      this.textColor,
      this.backgroundColor,
      this.font,
      this.fontWeight,
      this.border = 0,
      this.borderColor,
      this.borderRadius});

  /// 上下文，方便获取主题内容
  BuildContext? context;

  /// 文字颜色
  Color? textColor;

  /// 背景颜色
  Color? backgroundColor;

  /// 边框颜色
  Color? borderColor;

  /// 圆角
  BorderRadiusGeometry? borderRadius;

  /// 字体尺寸
  Font? font;

  /// 字体粗细
  FontWeight? fontWeight;

  /// 线框粗细
  double border = 0;

  /// 字体颜色，与属性不同名，方便子类自定义处理
  Color get getTextColor => textColor ?? THColor.white;

  /// 背景颜色，与属性不同名，方便子类自定义处理
  Color get getBackgroundColor =>
      backgroundColor ?? THColor.translucent;

  /// 线框颜色，与属性不同名，方便子类自定义处理
  Color get getBorderColor => borderColor ?? Colors.transparent;

  /// 圆角，，与属性不同名，方便子类自定义处理
  BorderRadiusGeometry? get getBorderRadius =>
      borderRadius;


}
