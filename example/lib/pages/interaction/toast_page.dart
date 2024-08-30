import 'package:example/pages/example_item.dart';
import 'package:example/pages/example_page.dart';
import 'package:flutter/material.dart';
import 'package:trade_hub/trade_hub.dart';

class ToastPage extends StatelessWidget {
  const ToastPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExamplePage(
      title: 'Toast 轻提示',
      children: [
        ExampleItem(
          title: "纯文字",
          widget: Material(child: _textToast(context)),
        ),
      ],
    );
  }

  Widget _textToast(BuildContext context) {
    return TextButton(
      onPressed: () {
        THToast.showText("这是一个纯文字的Toast", context: context);
      },
      child: const Text("纯文字Toast"),
    );
  }
}
