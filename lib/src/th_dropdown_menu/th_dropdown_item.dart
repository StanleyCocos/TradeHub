import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trade_hub/trade_hub.dart';

import '../util/color_ext.dart';
import 'th_dropdown_inherited.dart';
import 'th_dropdown_menu.dart';
import 'th_dropdown_popup.dart';

typedef THDropdownItemContentBuilder = Widget Function(BuildContext context,
    THDropdownItemState itemState, THDropdownPopup? popupState);

List<THDropdownItemOption> _getSelected(List<THDropdownItemOption>? options) {
  return options?.where((element) => element.selected == true).toList() ?? [];
}

/// 补充列数，使最后一行的选项宽度一样
int _num(List list, int? n) {
  var val = n ?? 1;
  if (list.length < val) {
    return val;
  }
  return list.length + list.length % val;
}

/// 下拉菜单
class THDropdownItem<T> extends StatefulWidget {
  const THDropdownItem({
    Key? key,
    this.disabled = false,
    this.label,
    this.multiple = false,
    this.options = const [],
    this.builder,
    this.optionsColumns = 1,
    this.onChange,
    this.onConfirm,
    this.onReset,
    this.minHeight,
    this.maxHeight,
    this.selectedColor,
    this.unselectedColor,
  }) : super(key: key);

  /// 是否禁用
  final bool? disabled;

  /// 标题
  final String? label;

  /// 是否多选
  final bool? multiple;

  /// 选项数据
  final List<THDropdownItemOption>? options;

  /// 完全自定义展示内容
  final THDropdownItemContentBuilder? builder;

  /// 选项分栏（1-3）
  final int? optionsColumns;

  /// 值改变时触发
  final ValueChanged<T?>? onChange;

  /// 点击确认时触发
  final ValueChanged<T?>? onConfirm;

  /// 点击重置时触发
  final VoidCallback? onReset;

  /// 内容最小高度
  final double? minHeight;

  /// 内容最大高度
  final double? maxHeight;

  final Color? selectedColor;
  final Color? unselectedColor;

  static const double operateHeight = 73;

  double? get minContentHeight => multiple == true
      ? (minHeight != null ? minHeight! + THDropdownItem.operateHeight : null)
      : minHeight;
  double? get maxContentHeight => multiple == true
      ? (maxHeight != null ? maxHeight! + THDropdownItem.operateHeight : null)
      : maxHeight;

  @override
  THDropdownItemState createState() => THDropdownItemState();

  String getLabel() {
    if (multiple == true) {
      return label ?? '';
    }
    var list = _getSelected(options);
    if (list.isEmpty) {
      return label ?? '';
    }
    return list[0]?.label ?? label ?? '';
  }
}

class THDropdownItemState extends State<THDropdownItem> {
  late THDropdownPopup popupState;
  late ValueNotifier<THDropdownMenuDirection> directionListenable;

  @override
  Widget build(BuildContext context) {
    popupState = THDropdownInherited.of(context)!.popupState;
    directionListenable = THDropdownInherited.of(context)!.directionListenable;
    if (widget.builder != null) {
      return widget.builder!(context, this, popupState);
    }
    return widget.multiple == true ? _getCheckboxList() : _getRadioList();
    //return _getRadioList2();
  }

  Widget _getRadioList() {
    var selected = _getSelected(widget.options);
    var radios = THCheckBox<THDropdownItemOption>(
      itemList: widget.options ?? [],
      checkedList: selected,
      direction: THCheckBoxDirection.vertical,
      type: THCheckBoxType.radio,
      itemCompare: (THDropdownItemOption a, THDropdownItemOption b) {
        return a.label == b.label;
      },
      onCheckChanged: (List<THDropdownItemOption> checkedList) {
        _handleSelectChange(checkedList, options: widget.options);
      },
      itemBuilder: (BuildContext context, int index, THDropdownItemOption item,
          bool isCheck) {
        return THCheckboxItem2(
          title: item.label,
          checked: isCheck,
          selectedColor: widget.selectedColor,
          unselectedColor: widget.unselectedColor,
        );
      },
    );
    return widget.minContentHeight != null || widget.maxContentHeight != null
        ? ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: widget.minContentHeight ?? 0.0,
                maxHeight: widget.maxContentHeight ?? double.infinity),
            child: widget.maxContentHeight != null
                ? SingleChildScrollView(child: radios)
                : radios,
          )
        : radios;
  }

  // 多选
  Widget _getCheckboxList() {
    var maxContentHeight = widget.maxContentHeight != null
        ? widget.maxContentHeight!
        : directionListenable.value == THDropdownMenuDirection.auto
            ? double.infinity
            : max<double>(
                popupState.maxContentHeight - THDropdownItem.operateHeight, 0);

    var selected = _getSelected(widget.options);
    print("selected:$selected, options:${widget.options}");
    var checkbox = THCheckBox<THDropdownItemOption>(
      itemList: widget.options ?? [],
      checkedList: selected,
      direction: THCheckBoxDirection.vertical,
      type: THCheckBoxType.checkbox,
      itemCompare: (THDropdownItemOption a, THDropdownItemOption b) {
        return a.label == b.label;
      },
      onClickCheckChanged:
          (List<THDropdownItemOption> checkedList, int index, bool isCheck) {
        _handleSelectChange(checkedList, options: widget.options);
      },
      itemBuilder: (BuildContext context, int index, THDropdownItemOption item,
          bool isCheck) {
        return THCheckboxItem2(
          title: item.label,
          checked: isCheck,
          selectedColor: widget.selectedColor,
          unselectedColor: widget.unselectedColor,
        );
      },
    );

    var body = Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: widget.minContentHeight ?? 0.0,
              maxHeight: maxContentHeight),
          child: SingleChildScrollView(
            child: checkbox,
          ),
        ),
        _getCheckboxOperate(),
      ],
    );
    return Material(
      child: Container(
        padding: const EdgeInsets.only(bottom: 20),
        color: THColor.white,
        child: body,
      ),
    );
  }

  // 多选-操作按钮-重置、确认
  Widget _getCheckboxOperate() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: 50,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                widget.options?.forEach((element) {
                  element.selected = false;
                });
                setState(() {});
                if (widget.onReset != null) {
                  widget.onReset!();
                }
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: THColor.grayEEEEEE, width: 1),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      bottomLeft: Radius.circular(24)),
                ),
                alignment: Alignment.center,
                child: Text(
                  "重置",
                  style: TextStyle(
                    fontSize: 16,
                    color: THColor.gray333333,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                _handleClose();
                if (widget.onConfirm != null) {
                  widget.onConfirm!(_getSelected(widget.options)
                      .map((e) => e!.value)
                      .toList());
                }
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: THColor.hex(0xFF6600),
                  // border: Border.all(color: ColorManager.grayEE, width: 1),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(24),
                      bottomRight: Radius.circular(24)),
                ),
                alignment: Alignment.center,
                child: Text(
                  "確認",
                  style: TextStyle(
                    fontSize: 16,
                    color: THColor.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

/*  Widget _getRadioList() {
    var selected = _getSelected(widget.options);
    var radios = THRadioGroup(
      onRadioGroupChange: _handleSelectChange,
      radioCheckStyle: THRadioStyle.check,
      selectId: selected.isEmpty ? null : selected[0]?.value,
      child: Column(
        children: List.generate(
          widget.options?.length ?? 0,
          (index) => THRadio(
            id: widget.options![index].value,
            title: widget.options![index].label,
            enable: !(widget.options![index].disabled ?? false),
          ),
        ),
      ),
    );
    return widget.minContentHeight != null || widget.maxContentHeight != null
        ? ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: widget.minContentHeight ?? 0.0, maxHeight: widget.maxContentHeight ?? double.infinity),
            child: widget.maxContentHeight != null ? SingleChildScrollView(child: radios) : radios,
          )
        : radios;
  }*/

  EdgeInsets _getPadding(int length, int index, String direction) {
    double value = length - 1 == index ? 0.0 : 12;
    if (direction == 'bottom') {
      return EdgeInsets.only(bottom: value);
    }
    if (direction == 'right') {
      return EdgeInsets.only(right: value);
    }
    return EdgeInsets.all(value);
  }

/*  Map<String, List<List<THDropdownItemOption>>> _groupChunkOptions() {
    var groupedOptions = widget.options?.groupBy<String>((option) => option.group ?? '__default__') ?? {};
    var groupedChunkOptions = <String, List<List<THDropdownItemOption>>>{};
    var def = groupedOptions.remove('__default__');
    if (def != null) {
      groupedOptions['__default__'] = def;
    }
    groupedOptions.forEach((key, value) {
      groupedChunkOptions[key] = value.chunk(widget.optionsColumns ?? 1);
    });
    return groupedChunkOptions;
  }*/

  void _handleSelectChange(List<THDropdownItemOption> checkedList,
      {List<THDropdownItemOption>? options}) {
    (options ?? widget.options ?? []).forEach((element) {element.selected = false;});
    for (var option in (options ?? widget.options ?? [])) {
      for (var item in checkedList){
        if (item.label == option.label) {
          option.selected = true;
          break;
        }
      }
    }

    if (widget.onChange != null) {
      widget.onChange!(
          _getSelected(widget.options).map((e) => e!.value).toList());
    }
    if (widget.multiple != true) {
      _handleClose();
    }
  }

  void _handleClose() async {
    if (widget.multiple != true) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    var handleClose = popupState.handleClose;
    if (handleClose != null) {
      unawaited(handleClose());
    }
  }

  void close() {
    _handleClose();
  }
}

/// 选项数据
class THDropdownItemOption {
  THDropdownItemOption({
    required this.value,
    required this.label,
    this.disabled = false,
    this.group,
    this.selected = false,
  });

  /// 选项值
  final String value;

  /// 选项标题
  final String label;

  /// 是否禁用
  final bool? disabled;

  /// 分组，相同的为一组
  final String? group;

  /// 是否选中
  late bool? selected;
}
