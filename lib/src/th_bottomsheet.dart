import 'package:flutter/material.dart';
import 'package:trade_hub/src/util/color_ext.dart';
import 'dart:ui' as ui;

class FBottomSheet {
  ///底部弹窗-列表
  static Future fBottomSheetOption(
    BuildContext context, {
    List<String>? option,
    String? initData,
    Function(int index, String value)? onSelect,
    Function? onClose,
    ShapeBorder? shape,
    bool isDismissible = true,
    double? maxHeight,
  }) async {
    var result = await showModalBottomSheet(
      context: context,
      shape: shape,
      isScrollControlled: true,
      isDismissible: isDismissible,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: _bottomBarHeight(),
            ),
            color: THColor.white,
            constraints: BoxConstraints(maxHeight: maxHeight ?? 400),
            child: FBottomSheetOption(
              list: option ?? [],
              initData: initData ?? "",
            ),
          ),
        );
      },
    );

    if (onSelect != null && result is List) {
      onSelect(result.first, result.last);
    } else {
      return onClose?.call();
    }
  }

  ///底部弹窗-视图
  static Future fBottomSheetView(
    BuildContext context, {
    required Widget content,
    Widget? title,
    Widget? bottom,
    bool isDismissible = true,
    ShapeBorder? shape,
    double? maxHeight,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: shape,
      isDismissible: isDismissible,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            constraints: BoxConstraints(maxHeight: maxHeight ?? 400),
            child: FBottomSheetView(
              title: title,
              content: content,
              bottom: bottom,
            ),
          ),
        );
      },
    );
  }

  ///底部弹窗-自定义
  static Future fBottomSheetViewCustom(
    BuildContext context, {
    required Widget content,
    Widget? title,
    Widget? bottom,
    bool isDismissible = true,
    ShapeBorder? shape,
    double? maxHeight,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: shape,
      isDismissible: isDismissible,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            constraints: BoxConstraints(maxHeight: maxHeight ?? 400),
            child: content,
          ),
        );
      },
    );
  }

  static double _bottomBarHeight() {
    var window = WidgetsBinding.instance?.window ?? ui.window;
    var pixelRatio = window.devicePixelRatio;
    var bottom = window.padding.bottom;
    var bottomBarHeight = bottom / pixelRatio;
    return bottomBarHeight;
  }
}

class FBottomSheetOption extends StatelessWidget {
  final List<String> list;
  final String initData;

  FBottomSheetOption({
    required this.list,
    required this.initData,
  });

  @override
  Widget build(BuildContext context) {
    return FBottomSheetView(
      content: contentView(context),
      bottom: bottomView(context),
    );
  }

  Widget contentView(BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < list.length; i++) {
      if (children.length > 0) {
        children.add(Divider(height: 1, color: Color(0xffE5E5E5)));
      }
      String it = list[i];
      bool select = it == initData;
      children.add(ListTile(
        onTap: () => itemClick(context, i, it),
        title: Text(
          it,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: select ? Colors.deepOrange : Color(0xff666666),
          ),
        ),
        selected: select,
      ));
    }

    return Column(children: children);
  }

  Widget bottomView(BuildContext context) {
    List<Widget> children = [];
    children.add(Divider(
      height: 16,
      color: Color(0xffE5E5E5),
      thickness: 16,
    ));

    children.add(InkWell(
      onTap: () => close(context),
      child: Container(
        height: 42,
        child: Text(
          '取消',
          style: TextStyle(fontSize: 16, color: Color(0xff666666)),
        ),
        alignment: Alignment.center,
      ),
    ));

    return Column(children: children);
  }

  void itemClick(BuildContext context, int index, String value) {
    close(context, result: [index, value]);
  }

  void close(BuildContext context, {var result}) {
    Navigator.pop(context, result);
  }
}

class FBottomSheetView extends StatelessWidget {
  final Widget? title;
  final Widget content;
  final Widget? bottom;

  FBottomSheetView({
    required this.content,
    this.title,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    if (title != null) {
      children.add(title!);
    }

    children.add(Flexible(
      child: SingleChildScrollView(
        child: content,
      ),
    ));

    if (bottom != null) {
      children.add(bottom!);
    }
    return Column(
      children: children,
      mainAxisSize: MainAxisSize.min,
    );
  }
}
