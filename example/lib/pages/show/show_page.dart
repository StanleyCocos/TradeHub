import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_hub/trade_hub.dart';

class ShowPage extends StatefulWidget {
  const ShowPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShowPageState();
}

class _ShowPageState extends State<ShowPage> {
  final List<String> _list = [
    '倒计时',
    '圆形加载',
    '轮播图',
    '标签'
    '头像'
  ];

  void onClick(int index) {
    String routeName = '';
    switch (index) {
      case 0:
        routeName = '/countdown';
        break;
      case 1:
        routeName = '/circle_loading';
        break;
      case 2:
        routeName = '/swiper';
        break;
      case 3:
        routeName = '/tag';
        break;
      case 4:
        routeName = '/avatar';
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
        title: const Text('展示'),
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
            onTap: () => onClick(index),
            child: Container(
              height: 50,
              color: Colors.white,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: Colors.white,
              child: Center(
                child: Text(
                  _list[index],
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
