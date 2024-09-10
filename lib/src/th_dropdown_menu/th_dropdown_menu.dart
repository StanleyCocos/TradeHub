import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_hub/src/util/color_ext.dart';
import 'package:trade_hub/src/util/iterable_ext.dart';
import 'package:trade_hub/trade_hub.dart';

import 'th_dropdown_item.dart';
import 'th_dropdown_popup.dart';

/// 菜单展开方向
enum THDropdownMenuDirection {
  /// 向下
  down,

  /// 向上
  up,

  /// 根据内容高度动态展示方向
  auto,
}

/// 下拉菜单构建器
typedef THDropdownItemBuilder = List<THDropdownItem> Function(
    BuildContext context);

/// 下拉菜单
class THDropdownMenu extends StatefulWidget {
  const THDropdownMenu({
    Key? key,
    this.builder,
    this.items,
    this.closeOnClickOverlay = true,
    this.direction = THDropdownMenuDirection.auto,
    this.duration = 200.0,
    this.showOverlay = true,
    this.isScrollable = false,
    this.arrowIcon,
    this.activateColor,
    this.onMenuOpened,
    this.onMenuClosed,
  }) : super(key: key);

  final Color? activateColor;

  /// 下拉菜单构建器，优先级高于[items]
  final THDropdownItemBuilder? builder;

  /// 下拉菜单
  final List<THDropdownItem>? items;

  /// 是否在点击遮罩层后关闭菜单
  final bool? closeOnClickOverlay;

  /// 菜单展开方向（down、up、auto）
  final THDropdownMenuDirection? direction;

  /// 动画时长，毫秒
  final double? duration;

  /// 是否显示遮罩层
  final bool? showOverlay;

  /// 自定义箭头图标
  final IconData? arrowIcon;

  /// 展开菜单事件
  final ValueChanged<int>? onMenuOpened;

  /// 关闭菜单事件
  final ValueChanged<int>? onMenuClosed;

  static _THDropdownMenuState? _currentOpenedInstance;

  /// 是否开启滚动列表
  final bool isScrollable;
  @override
  _THDropdownMenuState createState() => _THDropdownMenuState();
}

class _THDropdownMenuState extends State<THDropdownMenu>
    with TickerProviderStateMixin {
  List<THDropdownItem>? _items;
  List<AnimationController>? _iconControllers;
  late List<Animation<double>> _iconAnimations;
  late List<bool> _isOpened;
  THDropdownPopup? _dropdownPopup;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    _dropdownPopup?.overlayEntry?.remove();
    _dropdownPopup?.overlayEntry = null;
    THDropdownMenu._currentOpenedInstance = null;
    _iconControllers?.forEach((controller) {
      controller.dispose();
    });
    super.dispose();
  }

  @override
  void didUpdateWidget(THDropdownMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.builder != oldWidget.builder ||
        widget.items != oldWidget.items) {
      _init();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget tabBar = Row(
      children: List.generate(
        _items?.length ?? 0,
        (index) {
          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (_disabled(index)) {
                  return;
                }
                _isOpened[index] ? _closeMenu() : _openMenu(index);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_getText(index), _getIcon(index)],
              ),
            ),
          );
        },
      ),
    );
    if (widget.isScrollable) {
      tabBar = SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: List.generate(
            _items?.length ?? 0,
            (index) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (_disabled(index)) {
                    return;
                  }
                  _isOpened[index] ? _closeMenu() : _openMenu(index);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [_getText(index), _getIcon(index)],
                ),
              );
            },
          ),
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        var isClose = await _closeMenu();
        return !isClose;
      },
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: THColor.white,
          border: Border(
            bottom: BorderSide(
              color: THColor.grayE7E7E7,
              width: 1,
            ),
          ),
        ),
        child: tabBar,
      ),
    );
  }

  void _init() {
    var items = widget.builder?.call(context) ?? widget.items ?? [];
    if (items.length == _items?.length) {
      _items = items;
      return;
    }
    _isOpened = List.filled(items.length, false);
    _items = items;
    _iconControllers?.forEach((controller) {
      controller.dispose();
    });
    _iconControllers = List.generate(
        _items?.length ?? 0,
        (index) => AnimationController(
              duration:
                  Duration(milliseconds: (widget.duration ?? 200).toInt()),
              vsync: this,
            ));
    _iconAnimations = _iconControllers
            ?.map((e) => Tween<double>(begin: 0, end: 0.5).animate(e))
            .toList() ??
        [];
  }

  Widget _getText(int index) {
    var textColor = _disabled(index)
        ? THColor.black42000000
        : _isOpened[index]
            ? widget.activateColor ?? THColor.hex(0xFF6600)
            : _isActivate(index)
                ? widget.activateColor ?? THColor.hex(0xFF6600)
                : THColor.hex(0xE6000000);
    return THText(_items![index].getLabel(),
        font: Font(size: 15, lineHeight: 22), textColor: textColor);
  }

  Widget _getIcon(int index) {
    var arrowIcon = widget.arrowIcon ??
        (widget.direction == THDropdownMenuDirection.up
            ? Icons.keyboard_arrow_up_rounded
            : Icons.keyboard_arrow_down_rounded);
    return RotationTransition(
      turns: _iconAnimations[index],
      child: Icon(
        arrowIcon,
        size: 24,
        color: _disabled(index)
            ? THColor.black42000000
            : _isOpened[index]
                ? widget.activateColor ?? THColor.hex(0xFF6600)
                : _isActivate(index)
                    ? widget.activateColor ?? THColor.hex(0xFF6600)
                    : null,
      ),
    );
  }

  bool _disabled(int index) {
    return _items![index].disabled == true;
  }

  bool _isActivate(int index) {
    if(_items![index].multiple == true){
      var item = _items![index].options!.adFirstWhereOrNull((element) => element.selected == true);
      return item != null;
    }
    bool selected = _items![index].options!.firstOrNull?.selected ?? true;
    return !selected;
  }

  /// 打开菜单
  void _openMenu(int index) async {
    await THDropdownMenu._currentOpenedInstance?._closeMenu();
    THDropdownMenu._currentOpenedInstance = this;
    _dropdownPopup ??= THDropdownPopup(
      child: _items![index],
      parentContext: context,
      handleClose: _closeMenu,
      direction: widget.direction,
      showOverlay: widget.showOverlay,
      closeOnClickOverlay: widget.closeOnClickOverlay,
      duration: Duration(milliseconds: (widget.duration ?? 200).toInt()),
    );
    unawaited(_dropdownPopup!.add(_items![index]).then((value) {
      if (widget.onMenuOpened != null) {
        widget.onMenuOpened!(index);
      }
    }));

    _isOpened = List.filled(_items?.length ?? 0, false);
    _isOpened[index] = true;
    setState(() {});
    _iconControllers?.asMap().forEach((key, value) {
      if (value.status == AnimationStatus.completed) {
        value.reverse();
      } else if (key == index) {
        value.forward();
      }
    });
  }

  /// 关闭菜单
  Future<bool> _closeMenu() async {
    var index = _isOpened.indexOf(true);
    if (index < 0) {
      return false;
    }
    _isOpened = List.filled(_items?.length ?? 0, false);
    setState(() {});
    _iconControllers?.forEach((value) {
      if (value.status == AnimationStatus.completed) {
        value.reverse();
      }
    });
    await _dropdownPopup?.remove();
    THDropdownMenu._currentOpenedInstance = null;
    if (index >= 0 && widget.onMenuClosed != null) {
      widget.onMenuClosed!(index);
    }
    return true;
  }
}
