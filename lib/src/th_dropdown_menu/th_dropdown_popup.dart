import 'dart:async';

import 'package:flutter/material.dart';

import 'th_dropdown_inherited.dart';
import 'th_dropdown_item.dart';
import 'th_dropdown_menu.dart';
import 'th_dropdown_panel.dart';

typedef THDropdownPopupDirection = THDropdownMenuDirection;
typedef FutureCallback = Future<void> Function();

class THDropdownPopup {
  THDropdownPopup({
    required this.parentContext,
    required this.child,
    this.handleClose,
    this.direction = THDropdownPopupDirection.auto,
    this.showOverlay = true,
    this.closeOnClickOverlay = true,
    this.duration = const Duration(milliseconds: 200),
  });

  final BuildContext parentContext;
  final THDropdownItem child;
  final FutureCallback? handleClose;
  final THDropdownPopupDirection? direction;
  final bool? showOverlay;
  final bool? closeOnClickOverlay;
  final Duration? duration;

  /// _overlay1：下拉方向的
  /// _overlay2：menu部分的
  /// _overlay3：下拉反方向的
  /// _overlay3Height：下拉反方向的高度，用于判断auto方向
  /// _initContent：初始内容
  late double _overlay1Top,
      _overlay1Bottom,
      _overlay2Top,
      _overlay2Bottom,
      _overlay3Top,
      _overlay3Bottom,
      _overlay3Height,
      _initContentTop,
      _initContentBottom;
  late Future<void> Function() _closeContent;
  final _directionListenable = ValueNotifier<THDropdownPopupDirection>(THDropdownPopupDirection.auto);
  final _colorAlphaListenable = ValueNotifier<bool>(false);

  OverlayEntry? overlayEntry;

  Duration get _duration => duration ?? const Duration(milliseconds: 200);

  double get maxContentHeight => direction == THDropdownPopupDirection.down ? _initContentBottom : _initContentTop;

  void _init(THDropdownPopupDirection d) {
    var renderBox = parentContext.findRenderObject() as RenderBox;
    var position = renderBox.localToGlobal(Offset.zero);
    var size = renderBox.size;
    var screenHeight = MediaQuery.of(parentContext).size.height;
    if (d == THDropdownPopupDirection.down) {
      _overlay1Top = position.dy + size.height;
      _overlay2Top = position.dy;
      _overlay3Top = 0;
      _initContentTop = position.dy + size.height;

      _overlay1Bottom = 0;
      _overlay2Bottom = screenHeight - position.dy - size.height;
      _overlay3Bottom = screenHeight - position.dy;

      _overlay3Height = position.dy;
      _initContentBottom = screenHeight - position.dy - size.height;
    } else {
      _overlay1Top = 0;
      _overlay2Top = position.dy;
      _overlay3Top = position.dy + size.height;
      _initContentTop = position.dy;

      _overlay1Bottom = screenHeight - position.dy;
      _overlay2Bottom = screenHeight - position.dy - size.height;
      _overlay3Bottom = 0;

      _overlay3Height = screenHeight - position.dy - size.height;
      _initContentBottom = screenHeight - position.dy;
    }
  }

  Future<void> add([THDropdownItem? updateChild]) {
    var completer = Completer<void>();
    _directionListenable.value = direction ?? THDropdownPopupDirection.auto;
    overlayEntry?.remove();
    overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return _directionListenable.value == THDropdownPopupDirection.auto
            ? ValueListenableBuilder(
                valueListenable: _directionListenable,
                builder: (context, THDropdownPopupDirection value, child) => value == THDropdownPopupDirection.auto
                    ? child!
                    : _getPopup(value, updateChild, completer), // 每次重新渲染item，更新高度
                child: _getPopup(THDropdownPopupDirection.down, updateChild, completer),
              )
            : _getPopup(_directionListenable.value, updateChild, completer);
      },
    );

    Overlay.of(parentContext).insert(overlayEntry!);
    return completer.future;
  }

  Widget _getPopup(THDropdownMenuDirection value, THDropdownItem? updateChild, Completer<void> completer) {
    _init(value);
    final barrier = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _overlayClick,
    );
    return Stack(children: [
      if (_directionListenable.value != THDropdownPopupDirection.auto) ...[
        _getOverlay1(barrier),
        _getOverlay2(),
        _getOverlay3(barrier),
      ],
      THDropdownInherited(
          popupState: this,
          directionListenable: _directionListenable,
          child: THDropdownPanel(
            duration: _duration,
            direction: value,
            directionListenable: _directionListenable,
            colorAlphaListenable: _colorAlphaListenable,
            initContentBottom: _initContentBottom,
            initContentTop: _initContentTop,
            reverseHeight: _overlay3Height,
            closeCallback: _closeCallback,
            onOpened: () {
              completer.complete();
            },
            child: updateChild ?? child,
          )),
    ]);
  }

  Widget _getOverlay1(Widget barrier) {
    return Positioned(
      top: _overlay1Top,
      bottom: _overlay1Bottom,
      left: 0,
      right: 0,
      child: showOverlay == true
          ? ValueListenableBuilder(
              builder: (BuildContext context, bool value, Widget? child) {
                return AnimatedContainer(
                  color: value ? Colors.black54 : Colors.black54.withAlpha(0),
                  duration: _duration,
                  child: barrier,
                );
              },
              valueListenable: _colorAlphaListenable,
            )
          : barrier,
    );
  }

  Widget _getOverlay2() {
    return Positioned(
      top: _overlay2Top,
      bottom: _overlay2Bottom,
      left: 0,
      right: 0,
      child: GestureDetector(
        onVerticalDragUpdate: (details) {},
        onHorizontalDragUpdate: (details) {},
        behavior: HitTestBehavior.translucent,
      ),
    );
  }

  Widget _getOverlay3(Widget barrier) {
    return Positioned(
      top: _overlay3Top,
      bottom: _overlay3Bottom,
      left: 0,
      right: 0,
      child: barrier,
    );
  }

  void _overlayClick() {
    if (!(closeOnClickOverlay ?? true)) {
      return;
    }
    if (handleClose != null) {
      handleClose!();
    } else {
      remove();
    }
  }

  Future<void> remove() async {
    await _closeContent();
    overlayEntry?.remove();
    overlayEntry = null;
  }

  void _closeCallback(Future<void> Function() fn) {
    _closeContent = fn;
  }
}