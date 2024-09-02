

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_hub/trade_hub.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final List<String> _list = [
    '分割线',
    'text 组件'
  ];

  void onClick(int index){
    String routeName = '';
    switch(index){
      case 0:
        routeName = '/divider';
        break;
      case 1:
        routeName = '/text';
        break;
      default:
        routeName = '/base';
        break;
    }
    Get.toNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('基础'),
      ),
      body: ListView.separated(
        itemCount: _list.length,
        separatorBuilder: (_, __) {
          return const THDivider(
              margin: EdgeInsets.symmetric(vertical: 10)
          );
        },
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: ()=> onClick(index),
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
