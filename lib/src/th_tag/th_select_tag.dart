import 'package:flutter/material.dart';

import 'th_tag.dart';
import 'th_tag_styles.dart';

/// 点击型标签组件，点击时内部更改自身状态
/// 支持样式：方形/圆角/半圆/带关闭图标
class THSelectTag extends StatefulWidget {
  const THSelectTag(this.text,
      {this.icon,
      this.iconWidget,
      this.selectStyle,
      this.unSelectStyle,
      this.disableSelectStyle,
      this.onSelectChanged,
      this.isSelected = false,
      this.disableSelect = false,
      this.size = THTagSize.medium,
      this.padding,
      this.forceVerticalCenter = true,
      this.isOutline = false,
      this.shape = THTagShape.square,
      this.isLight = false,
      this.needCloseIcon = false,
      this.onCloseTap,
      Key? key})
      : super(key: key);

  /// 标签内容
  final String text;

  /// 图标内容，可随状态改变颜色
  final IconData? icon;

  /// 自定义图标内容，需自处理颜色
  final Widget? iconWidget;

  /// 选中的标签样式
  final THTagStyle? selectStyle;

  /// 未选中标签样式
  final THTagStyle? unSelectStyle;

  /// 不可选标签样式
  final THTagStyle? disableSelectStyle;

  /// 标签点击，选中状态改变时的回调
  final ValueChanged<bool>? onSelectChanged;

  /// 是否选中
  final bool isSelected;

  /// 是否禁用选择
  final bool disableSelect;

  /// 标签大小
  final THTagSize size;

  /// 自定义模式下的间距
  final EdgeInsets? padding;

  /// 是否强制中文文字居中
  final bool forceVerticalCenter;

  /// 是否为描边类型，默认不是
  final bool isOutline;

  /// 标签形状
  final THTagShape shape;

  /// 是否为浅色
  final bool isLight;

  /// 关闭图标
  final bool needCloseIcon;

  /// 关闭图标点击事件
  final GestureTapCallback? onCloseTap;

  @override
  _THClickTagState createState() => _THClickTagState();
}

class _THClickTagState extends State<THSelectTag> {
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    Widget result = THTag(
      widget.text,
      icon: widget.icon,
      iconWidget: widget.iconWidget,
      style: _getStyle(),
      size: widget.size,
      padding: widget.padding,
      forceVerticalCenter: widget.forceVerticalCenter,
      needCloseIcon: widget.needCloseIcon,
      onCloseTap: widget.onCloseTap,
    );
    if (!widget.disableSelect) {
      result = GestureDetector(
        onTap: () {
          setState(() {
            _isSelected = !_isSelected;
            widget.onSelectChanged?.call(_isSelected);
          });
        },
        child: result,
      );
    }
    return result;
  }

  THTagStyle? _getStyle() {
    if (widget.disableSelect) {
      return _getDisableSelectStyle();
    }
    return _isSelected ? _getSelectStyle() : _getUnSelectStyle();
  }

  THTagStyle _getDisableSelectStyle() {
    if (widget.disableSelectStyle != null) {
      return widget.disableSelectStyle!;
    }
    return THTagStyle();
  }

  THTagStyle _getSelectStyle() {
    if (widget.selectStyle != null) {
      return widget.selectStyle!;
    }
    return THTagStyle();
  }

  THTagStyle _getUnSelectStyle() {
    if (widget.unSelectStyle != null) {
      return widget.unSelectStyle!;
    }
    return THTagStyle();
  }

  @override
  void didUpdateWidget(covariant THSelectTag oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isSelected = widget.isSelected;
  }
}
