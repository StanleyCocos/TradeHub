import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trade_hub/src/th_circle_loading.dart';
import 'package:trade_hub/src/util/color_ext.dart';

enum IconTextDirection {
  horizontal, //横向
  vertical //竖向
}

class THToast {
  /// 普通文本Toast
  static void showText(String? text,
      {required BuildContext context,
      Duration duration = THToast._defaultDisPlayDuration,
      int? maxLines,
      BoxConstraints? constraints}) {
    _showOverlay(_THTextToast(text: text, maxLines: maxLines, constraints: constraints), context: context, duration: duration);
  }

  /// 带图标的Toast
  static void showIconText(String? text,
      {IconData? icon,
      IconTextDirection direction = IconTextDirection.horizontal,
      required BuildContext context,
      Duration duration = THToast._defaultDisPlayDuration}) {
    _showOverlay(
        _THIconTextToast(
          text: text,
          iconData: icon,
          iconTextDirection: direction,
        ),
        context: context,
        duration: duration);
  }

  /// 成功提示Toast
  static void showSuccess(String? text,
      {IconTextDirection direction = IconTextDirection.horizontal,
      required BuildContext context,
      Duration duration = THToast._defaultDisPlayDuration}) {
    _showOverlay(
        _THIconTextToast(
          text: text,
          iconData: Icons.check_circle_outline,
          iconTextDirection: direction,
        ),
        context: context,
        duration: duration);
  }

  /// 警告Toast
  static void showWarning(String? text,
      {IconTextDirection direction = IconTextDirection.horizontal,
      required BuildContext context,
      Duration duration = THToast._defaultDisPlayDuration}) {
    _showOverlay(
        _THIconTextToast(
          text: text,
          iconData: Icons.error_outline,
          iconTextDirection: direction,
        ),
        context: context,
        duration: duration);
  }

  /// 失败提示Toast
  static void showFail(String? text,
      {IconTextDirection direction = IconTextDirection.horizontal,
      required BuildContext context,
      Duration duration = THToast._defaultDisPlayDuration}) {
    _showOverlay(
        _THIconTextToast(
          text: text,
          iconData: Icons.close_rounded,
          iconTextDirection: direction,
        ),
        context: context,
        duration: duration);
  }

  /// 带文案的加载Toast
  static void showLoading(
      {required BuildContext context, String? text, Duration duration = THToast._infiniteDuration}) {
    _showOverlay(
        _THToastLoading(
          text: text,
        ),
        context: context,
        duration: duration);
  }

  /// 不带文案的加载Toast
  static void showLoadingWithoutText(
      {required BuildContext context, String? text, Duration duration = THToast._infiniteDuration}) {
    _showOverlay(const _THToastLoadingWithoutText(), context: context, duration: duration);
  }

  /// 关闭加载Toast
  static void dismissLoading() {
    _cancel();
  }

  static void _showOverlay(Widget? widget,
      {required BuildContext context, Duration duration = THToast._defaultDisPlayDuration}) {
    _cancel();
    _showing = true;
    var overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
        builder: (BuildContext context) => Center(
              child: AnimatedOpacity(
                opacity: _showing ? 1.0 : 0.0,
                duration: _showing ? const Duration(milliseconds: 100) : const Duration(milliseconds: 200),
                child: widget,
              ),
            ));
    if (_overlayEntry != null) {
      overlayState?.insert(_overlayEntry!);
    }
    _startTimer(duration);
  }

  static void _cancel() {
    _timer?.cancel();
    _timer = null;
    _disposeTimer?.cancel();
    _disposeTimer = null;
    _overlayEntry?.remove();
    _overlayEntry = null;
    _showing = false;
  }

  static void _startTimer(Duration duration) {
    _timer?.cancel();
    _disposeTimer?.cancel();
    _timer = Timer(duration, () {
      _showing = false;
      _overlayEntry?.markNeedsBuild();
      _timer = null;
      _disposeTimer = Timer(const Duration(milliseconds: 200), () {
        _overlayEntry?.remove();
        _overlayEntry = null;
        _disposeTimer = null;
      });
    });
  }

  static OverlayEntry? _overlayEntry;
  static bool _showing = false;
  static Timer? _timer;
  static Timer? _disposeTimer;
  static const Duration _defaultDisPlayDuration = Duration(milliseconds: 3000);
  static const Duration _infiniteDuration = Duration(seconds: 99999999);
}

class _THIconTextToast extends StatelessWidget {
  final String? text;
  final IconData? iconData;
  final IconTextDirection iconTextDirection;

  const _THIconTextToast({this.text, this.iconData, this.iconTextDirection = IconTextDirection.horizontal});

  Widget buildHorizontalWidgets(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 191, maxHeight: 94),
      child: Container(
          padding: const EdgeInsets.fromLTRB(24, 14, 24, 14),
          decoration: BoxDecoration(
            color: THColor.hex(0xE6000000),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 24,
                color: THColor.white,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                text ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  color: THColor.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              /*TDText(
                text ?? '',
                font: TDTheme.of(context).fontBodyMedium,
                fontWeight: FontWeight.w400,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textColor: TDTheme.of(context).whiteColor1,
              )*/
            ],
          )),
    );
  }

  Widget buildVerticalWidgets(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 136, maxHeight: 130),
        child: Container(
            height: 110,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: THColor.blackE6000000,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  iconData,
                  size: 32,
                  color: THColor.white,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  text ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color: THColor.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return iconTextDirection == IconTextDirection.horizontal
        ? buildHorizontalWidgets(context)
        : buildVerticalWidgets(context);
  }
}

class _THToastLoading extends StatelessWidget {
  final String? text;

  const _THToastLoading({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 110,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: THColor.blackE6000000,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            THCircleLoading(
              color: THColor.white,
              size: 26,
              strokeWidth: 4,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              text ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: THColor.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            /*TDText(
              text ?? context.resource.loadingWithPoint,
              font: TDTheme.of(context).fontBodyMedium,
              fontWeight: FontWeight.w400,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textColor: TDTheme.of(context).whiteColor1,
            )*/
          ],
        ));
  }
}

class _THToastLoadingWithoutText extends StatelessWidget {
  const _THToastLoadingWithoutText();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 80,
        height: 80,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: THColor.blackE6000000,
          borderRadius: BorderRadius.circular(6),
        ),
        child: THCircleLoading(
          color: THColor.white,
          size: 26,
          strokeWidth: 4,
        ));
  }
}

class _THTextToast extends StatelessWidget {
  final String? text;

  final int? maxLines;

  final BoxConstraints? constraints;

  const _THTextToast({this.text, this.maxLines, this.constraints});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: constraints ?? const BoxConstraints(maxWidth: 191, maxHeight: 94),
      child: Container(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
          decoration: BoxDecoration(
            color: THColor.blackE6000000,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            text ?? '',
            maxLines: maxLines ?? 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              color: THColor.white,
              fontWeight: FontWeight.w400,
            ),
          ),/*TDText(
            text ?? '',
            font: TDTheme.of(context).fontBodyMedium,
            fontWeight: FontWeight.w400,
            maxLines: maxLines ?? 3,
            overflow: TextOverflow.ellipsis,
            textColor: TDTheme.of(context).whiteColor1,
          ),*/
      ),
    );
  }
}
