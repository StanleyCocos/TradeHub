import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trade_hub/src/th_circle_loading.dart';
import 'package:trade_hub/src/util/color_ext.dart';
import 'th_cupertino_switch.dart';

/// 开关改变事件处理
typedef OnSwitchChanged = bool Function(bool value);

enum THSwitchSize { large, medium, small }

enum THSwitchType { fill, text, loading, icon }

class THSwitch extends StatefulWidget {
  const THSwitch({
    Key? key,
    this.enable = true,
    this.isOn = false,
    this.size = THSwitchSize.medium,
    this.type = THSwitchType.fill,
    this.trackOnColor,
    this.trackOffColor,
    this.thumbContentOnColor,
    this.thumbContentOffColor,
    this.onChanged,
    this.openText,
     this.closeText,
  }) : super(key: key);

  /// 是否可点击
  final bool enable;

  /// 是否打开
  final bool isOn;

  /// 开启时轨道颜色
  final Color? trackOnColor;

  /// 关闭时轨道颜色
  final Color? trackOffColor;

  /// 开启时ThumbView的颜色
  final Color? thumbContentOnColor;

  /// 关闭时ThumbView的颜色
  final Color? thumbContentOffColor;

  /// 尺寸：大、中、小
  final THSwitchSize? size;

  /// 类型：填充、文本、加载
  final THSwitchType? type;

  /// 改变事件
  final OnSwitchChanged? onChanged;

  /// 打开文案
  final String? openText;

  /// 关闭文案
  final String? closeText;

  @override
  State<StatefulWidget> createState() {
    return THSwitchState();
  }
}

class THSwitchState extends State<THSwitch> {
  bool isOn = false;

  @override
  void initState() {
    super.initState();
    isOn = widget.isOn;
  }

  @override
  void didUpdateWidget(covariant THSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    isOn = widget.isOn;
  }

  @override
  Widget build(BuildContext context) {
    final switchEnable = widget.enable && widget.type != THSwitchType.loading;
    final trackOnColor = widget.trackOnColor ?? THColor.orangeED702D;
    final trackOffColor = widget.trackOffColor ?? THColor.grayBBBBBB;
    final thumbContentOnColor = widget.thumbContentOnColor ?? THColor.grayA8A6A9;
    final thumbContentOffColor = widget.thumbContentOffColor ?? THColor.grayBBBBBB;
    Widget current = THCupertinoSwitch(
      value: isOn,
      activeColor: trackOnColor,
      trackColor: trackOffColor,
      onChanged: (value) {
        var process = widget.onChanged?.call(value) ?? false;
        // 如果外部未处理,才需要自定刷新开关,如果已处理则不需要刷新
        if (!process) {
          isOn = value;
          setState(() {});
        }
      },
      thumbView: _getThumbView(thumbContentOnColor, thumbContentOffColor),
    );
    if (!switchEnable) {
      current = Opacity(
        opacity: 0.4,
        child: IgnorePointer(
          ignoring: !switchEnable,
          child: current,
        ),
      );
    }
    return SizedBox(
      width: _getWidth(),
      height: _getHeight(),
      child: FittedBox(
        child: current,
      ),
    );
    // return ConstrainedBox( _getWidth(), height: _getHeight(), child: current);
  }

  double _getWidth() {
    switch (widget.size) {
      case THSwitchSize.large:
        return 52;
      case THSwitchSize.medium:
        return 45;
      case THSwitchSize.small:
        return 39;
      default:
        return 45;
    }
  }

  double _getHeight() {
    switch (widget.size) {
      case THSwitchSize.large:
        return 32;
      case THSwitchSize.medium:
        return 28;
      case THSwitchSize.small:
        return 24;
      default:
        return 28;
    }
  }

  Widget? _getThumbView(Color thumbContentOnColor, Color thumbContentOffColor) {
    switch (widget.type) {
      case THSwitchType.text:
        return Stack(
          children: [Container(
            alignment: Alignment.center,
            width: 16,
            child: Text(
              isOn ? (widget.openText ?? "on") : (widget.closeText ?? "off"),
              style: TextStyle(color: isOn ? thumbContentOnColor : thumbContentOffColor, fontSize: 10),
              maxLines: 1,
            ),
          )],
        );
      case THSwitchType.loading:
        return Container(
          alignment: Alignment.centerLeft,
          child: THCircleLoading(
            color: thumbContentOnColor,
            size: 16,
            strokeWidth: 3,
          ),
        );
      case THSwitchType.icon:
        return Container(
          alignment: Alignment.centerLeft,
          child: Icon(isOn ? Icons.check : Icons.close,
              size: 16, color: isOn ? thumbContentOnColor : thumbContentOffColor),
        );
      case THSwitchType.fill:
      default:
        return null;
    }
  }
}
