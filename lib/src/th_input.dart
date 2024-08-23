import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:trade_hub/src/th_divider.dart';
import 'package:trade_hub/src/util/color_ext.dart';
import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

enum THInputLimitAlign { below, tail }

enum THInputLayoutType { row, column }

class THInput extends StatefulWidget {
  const THInput({
    super.key,
    this.height,
    this.isMust = false,
    this.label,
    this.labelTitle,
    this.labelTitleStyle,
    this.showDivider = false,
    this.limitAlign = THInputLimitAlign.below,
    this.limitSuffix,
    this.isCounter = false,
    this.maxLength,
    this.showLimitLabel = true,
    this.limitLabelStyle,
    this.layoutType = THInputLayoutType.row,
    this.onLabelIconTap,
    this.labelIcon,
    this.labelIconWidget,
    this.showCleanButton = false,
    this.maxLines,
    this.textAlign,
    this.controller,
    this.hint,
    this.enabled = true,
    this.readOnly = false,
    this.onChanged,
    this.cursorHeight,
    this.decoration,
    this.editTextStyle,
    this.inputFormatters,
    this.keyboardType,
    this.focusNode,
  });

  final bool isMust;
  final Widget? label;
  final String? labelTitle;
  final TextStyle? labelTitleStyle;
  final bool showDivider;
  final double? height;

  /// 布局方式，默认为 row 横向布局
  final THInputLayoutType layoutType;

  /// 最大字数限制
  final int? maxLength;

  /// 最大行数限制
  final int? maxLines;

  /// 是否显示限制标签
  final bool showLimitLabel;

  /// 是否显示计数器
  final bool isCounter;

  /// 限制标签后缀
  final String? limitSuffix;

  /// 限制标签样式
  final TextStyle? limitLabelStyle;

  /// 计数器 counter 位置，默认在输入框下方
  final THInputLimitAlign limitAlign;

  ///-- LabelIcon 点击回调
  final GestureTapCallback? onLabelIconTap;

  ///-- LabelIcon
  final IconData? labelIcon;

  ///-- LabelIcon Widget
  final Widget? labelIconWidget;

  ///-- 是否显示清除按钮
  final bool showCleanButton;

  ///-- TextField 属性
  final TextEditingController? controller;
  final String? hint;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final double? cursorHeight;
  final InputDecoration? decoration;
  final TextStyle? editTextStyle;
  final bool readOnly;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;

  @override
  State createState() {
    return _THInputState();
  }
}

class _THInputState extends State<THInput> {
  late ValueNotifier<String> _valueNotifier;

  late TextEditingController _controller;

  @override
  void initState() {
    _valueNotifier = ValueNotifier(widget.controller?.text ?? "");
    _controller = widget.controller ?? TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.layoutType) {
      case THInputLayoutType.row:
        return _layoutByRow;
      case THInputLayoutType.column:
        return _layoutByColumn;
    }
  }

  Widget get _layoutByRow {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          height: widget.height ?? 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  widget.label ?? _label,
                  Expanded(
                    flex: 1,
                    child: _input,
                  ),
                  const SizedBox(width: 5),
                  _cleanButton,
                  Offstage(
                    offstage: widget.limitAlign != THInputLimitAlign.tail,
                    child: _counterText,
                  ),
                ],
              ),
              Offstage(
                offstage: widget.limitAlign != THInputLimitAlign.below,
                child: _counterText,
              )
            ],
          ),
        ),
        Offstage(
          offstage: !widget.showDivider,
          child: const THDivider(),
        )
      ],
    );
  }

  /// 竖向布局
  Widget get _layoutByColumn {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        widget.label ?? _label,
        const SizedBox(height: 8),

        /// 计数器在输入框后面
        Offstage(
          offstage: widget.limitAlign != THInputLimitAlign.tail,
          child: SizedBox(
            height: widget.height ?? 50,
            child: Row(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: _input,
                ),
                const SizedBox(width: 5),

                _counterText
              ],
            ),
          ),
        ),

        /// 计数器在输入框下面
        Offstage(
          offstage: widget.limitAlign != THInputLimitAlign.below,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: widget.height ?? 50,
                child: _input,
              ),
              _counterText,
            ],
          ),
        ),
        Offstage(
          offstage: !widget.showDivider,
          child: const THDivider(),
        )
      ],
    );
  }

  Widget get _label {
    return Container(
      //height: 25,
      //color: Colors.white,
      child: Row(
        children: [
          Offstage(
            offstage: !widget.isMust,
            child: Text(
              "*",
              style: TextStyle(
                color: THColor.redFF596B,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            widget.labelTitle ?? "",
            style: widget.labelTitleStyle ??
                TextStyle(
                  color: THColor.gray333333,
                  fontSize: 16,
                ),
          ),
          _labelIconWidget,
        ],
      ),
    );
  }

  /// LabelIcon Widget
  Widget get _labelIconWidget {
    if (widget.labelIconWidget != null) {
      return widget.labelIconWidget!;
    } else {
      return Offstage(
        offstage: widget.labelIcon == null,
        child: GestureDetector(
          onTap: () {
            widget.onLabelIconTap?.call();
          },
          child: Container(
              width: 10,
              height: widget.height,
              alignment: Alignment.center,
              // 这里显示偏上 特别调整一下
              padding: const EdgeInsets.only(top: 2),
              child: Icon(
                widget.labelIcon,
                size: 17,
                color: THColor.blue5E92F6,
              )),
        ),
      );
    }
  }

  Widget get _input {
    return _rawInput;
  }

  Widget get _rawInput {
    return TextField(
        controller: _controller,
        focusNode: widget.focusNode,
        cursorHeight: widget.cursorHeight,
        cursorColor: THColor.orangeED702D,
        style: widget.editTextStyle ??
            TextStyle(
                height: 1.1,
                color: widget.enabled ? THColor.gray333333 : THColor.grayA8A6A9,
                fontSize: 16),
        textAlign: widget.textAlign ?? TextAlign.end,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        keyboardType: widget.keyboardType,
        decoration: widget.decoration ??
            InputDecoration(
              border: InputBorder.none,
              hintText: widget.hint,
              hintStyle: TextStyle(
                color: THColor.grayCCCCCC,
              ),
              //isCollapsed: true,
              counterText: "",
            ),
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        inputFormatters: widget.inputFormatters ??
            [LengthLimitingTextInputFormatter(widget.maxLength)],
        onChanged: (value) {
          widget.onChanged?.call(value);
          _valueNotifier?.value = value;
        });
  }

  /// 计数器
  /// 计数器可单独显示也可以和 限制数一起显示
  Widget get _counterText {
    if (widget.maxLength != null && widget.showLimitLabel) {
      return _limitLabel;
    }
    if (widget.isCounter) {
      return ValueListenableBuilder(
        valueListenable: _valueNotifier!,
        builder: (BuildContext context, String value, Widget? child) {
          return _limitLabelText("${value.length}${widget.limitSuffix ?? ""}");
        },
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget get _limitLabel {
    if (widget.isCounter) {
      return ValueListenableBuilder(
        valueListenable: _valueNotifier!,
        builder: (BuildContext context, String value, Widget? child) {
          return _limitLabelText(
              "${value.length}/${widget.maxLength}${widget.limitSuffix ?? ""}");
        },
      );
    } else {
      return _limitLabelText("${widget.maxLength}${widget.limitSuffix ?? ""}");
    }
  }

  Widget get _cleanButton {
    return ValueListenableBuilder(
      valueListenable: _valueNotifier,
      builder: (BuildContext context, String value, Widget? child) {
        bool isShow = widget.showCleanButton && value.isNotEmpty;
        return Offstage(
          offstage: !isShow,
          child: GestureDetector(
            onTap: () {
              _controller?.clear();
              _valueNotifier?.value = "";
            },
            child: Container(
              padding: const EdgeInsets.only(right: 5),
              child: Icon(
                Icons.cancel,
                size: 20,
                color: THColor.grayCCCCCC,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _limitLabelText(String value) {
    return Text(
      value,
      style: widget.limitLabelStyle ??
          TextStyle(
            fontSize: 13,
            color: THColor.grayBBBBBB,
          ),
    );
  }
}
