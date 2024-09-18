import 'package:example/pages/example_item.dart';
import 'package:example/pages/example_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trade_hub/trade_hub.dart';

class DialogPage extends StatefulWidget {
  const DialogPage({Key? key}) : super(key: key);

  @override
  State<DialogPage> createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  final String _title = "标题";
  final String _content = "内容内容内容内容内容内容内容内容内容";
  final String _longContent =
      "很长的内容很长的内容很长的内容很长的内容很长的内容很长的内容很长的内容很长的内容很长的内容很长的内容很长的内容很长的内容很长的内容很长的内容很长的内容很长的内容很长的内容很长的内容很长的内容";

  @override
  Widget build(BuildContext context) {
    return ExamplePage(
      children: [
        ExampleItem(title: "基础弹窗", widget: _normalDialog(context)),
        ExampleItem(title: "不带标题弹窗", widget: _notTitleDialog(context)),
        ExampleItem(title: "禁用取消按钮", widget: _notCancelBtnDialog(context)),
        ExampleItem(title: "更改按钮文案和样式", widget: _btnTextStyleDialog(context)),
        ExampleItem(title: "自定义底部 Widget", widget: _customBottomWidgetDialog(context)),

        ExampleItem(title: "输入框弹窗", widget: _inputDialog(context)),

      ],
    );
  }

  Widget _inputDialog(BuildContext context){
    return THButton.high(
      text: "输入框弹窗",
      onTap: () {
        THInputDialog.show(
          context,
          title: _title,
          content: _content,
          hintText: "请输入内容",
        );
      },
    );
  }

  Widget _customBottomWidgetDialog(BuildContext context){
    return THButton.high(
      text: "自定义底部 Widget",
      onTap: () {
        THDialog.show(
          context,
          title: _title,
          content: _content,
          bottomWidget: Material(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    THToast.showText("自定义按钮点击1", context: context);
                    // 设置点击事件后，需要自行处理关闭弹窗
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 32,
                    margin: const EdgeInsets.symmetric(horizontal: 16, ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.orange,
                    ),
                    child: const Center(
                      child: THText(
                        "自定义按钮1",
                        textAlign: TextAlign.center,
                        forceVerticalCenter: true,
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    THToast.showText("自定义按钮点击2", context: context);
                    // 设置点击事件后，需要自行处理关闭弹窗
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 32,
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10 ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.orange.withAlpha(100),
                    ),
                    child: const Center(
                      child: THText(
                        "自定义按钮2",
                        textAlign: TextAlign.center,
                        forceVerticalCenter: true,
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _btnTextStyleDialog(BuildContext context) {
    return THButton.high(
      text: "更改按钮文案和样式",
      onTap: () {
        THDialog.show(
          context,
          title: _title,
          content: _content,
          cancelBtnOptions: THDialogBtnOptions(
            text: "左侧按钮",
            textStyle: const TextStyle(
              color: Colors.red,
            ),
            onTap: () {
              THToast.showText("左侧按钮点击", context: context);
              // 设置点击事件后，需要自行处理关闭弹窗
              Navigator.pop(context);
            },
          ),
          confirmBtnOptions: THDialogBtnOptions(
            text: "右侧按钮",
            textStyle: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
            onTap: () {
              THToast.showText("右侧按钮点击", context: context);
              // 设置点击事件后，需要自行处理关闭弹窗
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  Widget _notCancelBtnDialog(BuildContext context) {
    return THButton.high(
      text: "禁用取消按钮",
      onTap: () {
        THDialog.show(
          context,
          title: _title,
          content: _content,
          cancelBtnEnable: false,
        );
      },
    );
  }

  Widget _normalDialog(BuildContext context) {
    return THButton.high(
      text: "默认弹窗",
      onTap: () {
        THDialog.show(
          //title 和 content 不能同时为空
          context,
          title: _title,
          content: _content,
        );
      },
    );
  }

  Widget _notTitleDialog(BuildContext context) {
    return THButton.high(
      text: "不带标题弹窗",
      onTap: () {
        THDialog.show(
          //title 和 content 不能同时为空
          context,
          content: _longContent,
        );
      },
    );
  }
}
