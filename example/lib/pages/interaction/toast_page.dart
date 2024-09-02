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
          widget: _textToast(context),
        ),
        ExampleItem(
          title: "多行文字",
          widget: _multipleToast(context),
        ),
        ExampleItem(
          title: "带横向图标",
          widget: _horizontalIconToast(context),
        ),
        ExampleItem(
          title: "带竖向图标",
          widget: _verticalIconToast(context),
        ),
        ExampleItem(
          title: "加载状态",
          widget: _loadingToast(context),
        ),
        ExampleItem(
          title: "加载状态(无文字)",
          widget: _loadingWithoutTextToast(context),
        ),
        ExampleItem(
          title: "停止加载",
          widget: _dismissLoadingToast(context),
        ),
        ExampleItem(
          title: "成功提示",
          widget: _successToast(context),
        ),
        ExampleItem(
          title: "成功提示(竖向)",
          widget: _successVerticalToast(context),
        ),
        ExampleItem(
          title: "警告提示",
          widget: _warningToast(context),
        ),
        ExampleItem(
          title: "警告提示(竖向)",
          widget: _warningVerticalToast(context),
        ),
        ExampleItem(
          title: "失败提示",
          widget: _failToast(context),
        ),
        ExampleItem(
          title: "失败提示(竖向)",
          widget: _failVerticalToast(context),
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

  Widget _multipleToast(BuildContext context) {
    return TextButton(
      onPressed: () {
        THToast.showText("多行文字，限制最多不超过三行文字，不信你看，不信你看，不信你看，不信你再看",
            context: context);
      },
      child: const Text("多行文字Toast"),
    );
  }

  Widget _horizontalIconToast(BuildContext context) {
    return TextButton(
      onPressed: () {
        THToast.showIconText("横向带图标",
            icon: Icons.warning_amber, context: context);
      },
      child: const Text("横向带图标Toast"),
    );
  }

  Widget _verticalIconToast(BuildContext context) {
    return TextButton(
      onPressed: () {
        THToast.showIconText(
          "带竖向图标",
          icon: Icons.warning_amber,
          direction: IconTextDirection.vertical,
          context: context,
        );
      },
      child: const Text("带竖向图标Toast"),
    );
  }

  Widget _loadingToast(BuildContext context) {
    return TextButton(
      onPressed: () {
        THToast.showLoading(context: context);
      },
      child: const Text("加载状态"),
    );
  }

  Widget _loadingWithoutTextToast(BuildContext context) {
    return TextButton(
      onPressed: () {
        THToast.showLoadingWithoutText(context: context);
      },
      child: const Text("加载状态(无文字)"),
    );
  }

  Widget _dismissLoadingToast(BuildContext context) {
    return TextButton(
      onPressed: () {
        THToast.dismissLoading();
      },
      child: const Text("停止加载"),
    );
  }

  Widget _successToast(BuildContext context) {
    return TextButton(
      onPressed: () {
        THToast.showSuccess("成功提示", context: context);
      },
      child: const Text("成功提示"),
    );
  }

  Widget _successVerticalToast(BuildContext context) {
    return TextButton(
      onPressed: () {
        THToast.showSuccess("成功提示",
            context: context, direction: IconTextDirection.vertical);
      },
      child: const Text("成功提示(竖向)"),
    );
  }

  Widget _warningToast(BuildContext context) {
    return TextButton(
      onPressed: () {
        THToast.showWarning("警告提示", context: context);
      },
      child: const Text("警告提示"),
    );
  }

  Widget _warningVerticalToast(BuildContext context) {
    return TextButton(
      onPressed: () {
        THToast.showWarning("警告提示",
            context: context, direction: IconTextDirection.vertical);
      },
      child: const Text("警告提示(竖向)"),
    );
  }

  Widget _failToast(BuildContext context) {
    return TextButton(
      onPressed: () {
        THToast.showFail("失败提示", context: context);
      },
      child: const Text("失败提示"),
    );
  }

  Widget _failVerticalToast(BuildContext context) {
    return TextButton(
      onPressed: () {
        THToast.showFail("失败提示",
            context: context, direction: IconTextDirection.vertical);
      },
      child: const Text("失败提示(竖向)"),
    );
  }
}
