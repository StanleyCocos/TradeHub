import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_hub/trade_hub.dart';

///交互组件页面
class InteractionPage extends StatefulWidget {
  const InteractionPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InteractionPageState();
}

class _InteractionPageState extends State<InteractionPage> {
  final List<String> _list = [
    "单选",
    "输入框",
    "数量编辑器",
    "开关 Switch",
    "轻提示 Toast",
    "选择器",
    "dialog 弹窗",
    "下拉菜单"
  ];

  void onClick(int index) {
    String routeName = '';
    switch (index) {
      case 0:
        routeName = '/check_box';
        break;
      case 1:
        routeName = '/input';
        break;
      case 2:
        routeName = '/quantity_editor';
        break;
      case 3:
        routeName = '/switch';
        break;
      case 4:
        routeName = '/toast';
        break;
      case 5:
        routeName = '/picker';
        break;
      case 6:
        routeName = '/dialog';
        break;
      case 7:
        routeName = '/dropdown_menu';
        break;
      default:
        routeName = '/interaction';
        break;
    }
    Get.toNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('交互'),
      ),
      body: ListView.separated(
        itemCount: _list.length,
        separatorBuilder: (_, __) {
          return const THDivider(margin: EdgeInsets.symmetric(vertical: 10));
        },
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: () => onClick(index),
            child: Container(
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _list[index],
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
