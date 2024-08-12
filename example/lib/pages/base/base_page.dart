

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final List<String> _list = [
    '分割线',
  ];

  void onClick(int index){
    String routeName = '';
    switch(index){
      case 0:
        routeName = '/divider';
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
          return const Divider(
            endIndent: 16,
            indent: 16,
            height: 1,
            color: Colors.black,
            thickness: 1,
          );
        },
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: ()=> onClick(index),
            child: Container(
              height: 50,
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
