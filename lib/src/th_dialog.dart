import 'package:flutter/material.dart';
import 'package:trade_hub/src/util/color_ext.dart';
import 'package:trade_hub/trade_hub.dart';


/// 带有输入框的弹窗
class THInputDialog extends StatelessWidget {

  static show(
    BuildContext context, {
    Key? key,
    Color backgroundColor = Colors.white,
    double radius = 12.0,
    String? title,
    Color titleColor = const Color(0xE6000000),
    AlignmentGeometry? titleAlignment,
    Widget? contentWidget,
    String? content,
    String hintText = '',
    Color? contentColor,
    TextEditingController? textEditingController,
    bool cancelBtnEnable = true,
    THDialogBtnOptions? cancelBtnOptions,
    THDialogBtnOptions? confirmBtnOptions,
    bool? showCloseButton,
    Widget? bottomWidget,
  }) {
    showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return THInputDialog(
          key: key,
          backgroundColor: backgroundColor,
          radius: radius,
          title: title,
          titleColor: titleColor,
          titleAlignment: titleAlignment,
          contentWidget: contentWidget,
          content: content,
          hintText: hintText,
          contentColor: contentColor,
          textEditingController: textEditingController ?? TextEditingController(),
          cancelBtnEnable: cancelBtnEnable,
          cancelBtnOptions: cancelBtnOptions,
          confirmBtnOptions: confirmBtnOptions,
          showCloseButton: showCloseButton,
          bottomWidget: bottomWidget,
        );
      },
    );
  }

  THInputDialog({
    Key? key,
    required this.textEditingController,
    this.backgroundColor = Colors.white,
    this.radius = 12.0,
    this.title,
    this.titleColor = const Color(0xE6000000),
    this.titleAlignment,
    this.contentWidget,
    this.content,
    this.hintText = '',
    this.contentColor,
    this.cancelBtnEnable = true,
    this.cancelBtnOptions,
    this.confirmBtnOptions,
    this.showCloseButton,
    this.bottomWidget,
  })  : assert((title != null || content != null)),
        super(key: key);

  /// 背景颜色
  final Color backgroundColor;

  /// 圆角
  final double radius;

  /// 标题
  final String? title;

  /// 标题颜色
  final Color titleColor;

  /// 标题对齐模式
  final AlignmentGeometry? titleAlignment;

  /// 内容Widget
  final Widget? contentWidget;

  /// 内容
  final String? content;

  /// 输入提示
  final String? hintText;

  /// 内容颜色
  final Color? contentColor;

  /// 输入controller
  final TextEditingController textEditingController;

  final bool cancelBtnEnable;
  /// 取消按钮配置
  THDialogBtnOptions? cancelBtnOptions;

  /// 确定按钮配置
  THDialogBtnOptions? confirmBtnOptions;

  /// 显示右上角关闭按钮
  final bool? showCloseButton;

  /// 底部Widget，方便自定义按钮
  final Widget? bottomWidget;

  @override
  Widget build(BuildContext context) {
    return THDialogScaffold(
      showCloseButton: showCloseButton,
      backgroundColor:backgroundColor,
      radius: radius,
      body: Material(
        color:backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        child: Column(
            mainAxisSize: MainAxisSize.min, children: [
          THDialogInfoWidget(
            title: title,
            titleColor: titleColor,
            titleAlignment: titleAlignment,
            contentWidget: contentWidget,
            content: content,
            contentColor: contentColor,
          ),
          Container(
            height: 48,
            margin: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(radius)),
            ),
            child: TextField(
              controller: textEditingController,
              autofocus: true,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none),
                hintText: hintText,
                hintStyle: const TextStyle(color: Color(0x66000000)),
                fillColor: const Color(0xFFF3F3F3),
                filled: true,
                // labelText: '左上角',
              ),
            ),
          ),
          _bottomButton,
        ]),
      ),
    );
  }

  Widget get _bottomButton {
    if (bottomWidget != null) {
      return bottomWidget!;
    }
    return BottomButtons(
      cancelBtnEnable: cancelBtnEnable,
      cancelBtnOptions: cancelBtnOptions,
      confirmBtnOptions: confirmBtnOptions,
    );
  }
}

/// 普通弹窗
class THDialog extends StatelessWidget {

  /// 显示弹窗
  static show(
    BuildContext context, {
    Key? key,
    Color backgroundColor = Colors.white,
    double radius = 12.0,
    String? title,
    Color titleColor = const Color(0xE6000000),
    AlignmentGeometry? titleAlignment,
    Widget? contentWidget,
    String? content,
    Color? contentColor,
    double contentMaxHeight = 0,
    bool? showCloseButton,
    bool cancelBtnEnable = true,
    THDialogBtnOptions? cancelBtnOptions,
    THDialogBtnOptions? confirmBtnOptions,
    Widget? bottomWidget,
  }) {
    showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return THDialog(
          key: key,
          backgroundColor: backgroundColor,
          radius: radius,
          title: title,
          titleColor: titleColor,
          titleAlignment: titleAlignment,
          contentWidget: contentWidget,
          content: content,
          contentColor: contentColor,
          contentMaxHeight: contentMaxHeight,
          showCloseButton: showCloseButton,
          cancelBtnEnable: cancelBtnEnable,
          cancelBtnOptions: cancelBtnOptions,
          confirmBtnOptions: confirmBtnOptions,
          bottomWidget: bottomWidget,
        );
      },
    );
  }

  /// title 和 content 不能同时为空
  THDialog({
    super.key,
    this.backgroundColor = Colors.white,
    this.radius = 12.0,
    this.title,
    this.titleColor = const Color(0xE6000000),
    this.titleAlignment,
    this.contentWidget,
    this.content,
    this.contentColor,
    this.contentMaxHeight = 0,
    this.showCloseButton,
    this.cancelBtnEnable = true,
    this.cancelBtnOptions,
    this.confirmBtnOptions,
    this.bottomWidget,
  });

  /// 背景颜色
  final Color backgroundColor;

  /// 圆角
  final double radius;

  /// 标题
  final String? title;

  /// 标题颜色
  final Color titleColor;

  /// 标题对齐模式
  final AlignmentGeometry? titleAlignment;

  /// 内容Widget
  final Widget? contentWidget;

  /// 内容
  final String? content;

  /// 内容颜色
  final Color? contentColor;

  /// 内容的最大高度，默认为0，也就是不限制高度
  final double contentMaxHeight;

  /// 显示右上角关闭按钮
  final bool? showCloseButton;

  /// 是否显示取消按钮
  final bool cancelBtnEnable;

  /// 取消按钮配置
  THDialogBtnOptions? cancelBtnOptions;

  /// 确定按钮配置
  THDialogBtnOptions? confirmBtnOptions;

  /// 底部Widget，方便自定义按钮
  final Widget? bottomWidget;

  @override
  Widget build(BuildContext context) {
    // 标题和内容不能同时为空
    return THDialogScaffold(
        showCloseButton: showCloseButton,
        backgroundColor: backgroundColor,
        radius: radius,
        body: Column(mainAxisSize: MainAxisSize.min, children: [
          THDialogInfoWidget(
            title: title,
            titleColor: titleColor,
            titleAlignment: titleAlignment,
            contentWidget: contentWidget,
            content: content,
            contentColor: contentColor,
            contentMaxHeight: contentMaxHeight,
          ),
          const THDivider(height: 24, color: Colors.transparent),
          _bottomButton,
        ]));
  }

  Widget get _bottomButton {
    if (bottomWidget != null) {
      return bottomWidget!;
    }
    return BottomButtons(
      cancelBtnEnable: cancelBtnEnable,
      cancelBtnOptions: cancelBtnOptions,
      confirmBtnOptions: confirmBtnOptions,
    );
  }
}

/// THDialog手脚架
class THDialogScaffold extends StatelessWidget {
  const THDialogScaffold({
    Key? key,
    required this.body,
    this.showCloseButton,
    this.backgroundColor = Colors.white,
    this.radius = 12.0,
  }) : super(key: key);

  /// Dialog主体
  final Widget body;

  /// 显示右上角关闭按钮
  final bool? showCloseButton;

  /// 背景色
  final Color backgroundColor;

  /// 圆角
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        child: Container(
          width: 311,
          decoration: BoxDecoration(
            color: backgroundColor, // 底色
            //borderRadius: BorderRadius.all(Radius.circular(radius)),
          ),
          child: Stack(
            children: [
              body,
              showCloseButton ?? false
                  ? Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                          width: 38,
                          height: 38,
                          child: Center(
                            child: Icon(
                              Icons.close_rounded,
                              size: 22,
                              color: THColor.black66000000,
                            ),
                          ),
                        ),
                      ))
                  : Container(height: 0)
            ],
          ),
        ),
      ),
    );
  }
}

/// 弹窗标题
/*class THDialogTitle extends StatelessWidget {
  const THDialogTitle({
    Key? key,
    this.title,
    this.titleColor = Colors.black,
  }) : super(key: key);

  /// 标题颜色
  final Color titleColor;

  /// 标题文字
  final String? title;

  @override
  Widget build(BuildContext context) {
    // 标题和内容不能同时为空
    return THText(
      title,
      textColor: titleColor,
      fontWeight: FontWeight.w600,
      font: Font(size: 16, lineHeight: 24),
      textAlign: TextAlign.center,
    );
  }
}*/

/// 弹窗内容
class THDialogContent extends StatelessWidget {
  const THDialogContent({
    Key? key,
    this.content,
    this.contentColor = const Color(0x99000000),
  }) : super(key: key);

  /// 标题颜色
  final Color contentColor;

  /// 标题文字
  final String? content;

  @override
  Widget build(BuildContext context) {
    // 标题和内容不能同时为空
    return THText(
      content,
      textColor: contentColor,
      font: Font(size: 16, lineHeight: 24),
      textAlign: TextAlign.center,
    );
  }
}

/// 弹窗信息
class THDialogInfoWidget extends StatelessWidget {
  const THDialogInfoWidget({
    Key? key,
    this.title,
    this.titleColor = Colors.black,
    this.titleAlignment,
    this.contentWidget,
    this.content,
    this.contentColor,
    this.contentMaxHeight = 0,
    this.padding = const EdgeInsets.fromLTRB(24, 22, 24, 0),
  }) : super(key: key);

  /// 标题
  final String? title;

  /// 标题颜色
  final Color titleColor;

  /// 标题对齐模式
  final AlignmentGeometry? titleAlignment;

  /// 内容Widget
  final Widget? contentWidget;

  /// 内容
  final String? content;

  /// 内容颜色
  final Color? contentColor;

  /// 内容的最大高度，默认为0，也就是不限制高度
  final double contentMaxHeight;

  /// 内容的内边距
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    // 标题和内容不能同时为空
    assert((title != null || content != null));
    return Container(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null)
            Align(
              alignment: titleAlignment ?? Alignment.center,
              child: THText(
                title,
                textColor: titleColor,
                fontWeight: FontWeight.w600,
                font: Font(size: 18, lineHeight: 26),
                textAlign: TextAlign.center,
              ),
            ),
          if (contentWidget != null || content != null)
            Container(
              padding: EdgeInsets.fromLTRB(
                  0, (title != null && content != null) ? 12.0 : 0, 0, 0),
              constraints: contentMaxHeight > 0
                  ? BoxConstraints(
                      maxHeight: contentMaxHeight,
                    )
                  : null,
              child: contentWidget ??
                  Scrollbar(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: THDialogContent(
                        content: content!,
                        contentColor: contentColor ?? const Color(0x99000000),
                      ),
                    ),
                  ),
            ),
        ],
      ),
    );
  }
}

/// 左右横向文字按钮，顶部和中间有分割线
class BottomButtons extends StatelessWidget {
  BottomButtons({
    Key? key,
    this.cancelBtnEnable = true,
    this.cancelBtnOptions,
    this.confirmBtnOptions,
  }) : super(key: key);

  final bool cancelBtnEnable;
  THDialogBtnOptions? cancelBtnOptions;
  THDialogBtnOptions? confirmBtnOptions;

  @override
  Widget build(BuildContext context) {
    // 标题和内容不能同时为空
    return Column(
      children: [
        const THDivider(height: 1),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (cancelBtnEnable)
              Expanded(
                child: GestureDetector(
                  onTap: cancelBtnOptions?.onTap ??
                      () {
                        Navigator.pop(context);
                      },
                  child: cancelBtnOptions?.btnWidget ??
                      THText(
                        cancelBtnOptions?.text ?? '取消',
                        textAlign: TextAlign.center,
                        style: cancelBtnOptions?.textStyle ??
                            TextStyle(
                              fontSize: 16,
                              color: THColor.grayFFFFFF,
                            ),
                      ),
                ),
              ),
            THDivider(
              width: cancelBtnEnable ? 1 : 0,
              height: 56,
            ),
            Expanded(
              child: GestureDetector(
                onTap: confirmBtnOptions?.onTap ??
                    () {
                      Navigator.pop(context);
                    },
                child: confirmBtnOptions?.btnWidget ??
                    THText(
                      confirmBtnOptions?.text ?? '確定',
                      textAlign: TextAlign.center,
                      style: confirmBtnOptions?.textStyle ??
                          TextStyle(
                            fontSize: 16,
                            color: THColor.black99000000,
                          ),
                    ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class THDialogBtnOptions {
  THDialogBtnOptions({
    this.text,
    this.textStyle,
    this.onTap,
    this.btnWidget,
  });

  final String? text;
  final Function()? onTap;
  final TextStyle? textStyle;
  final Widget? btnWidget;
}
