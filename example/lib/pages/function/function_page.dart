import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_hub/trade_hub.dart';

class FunctionPage extends StatefulWidget {
  const FunctionPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FunctionPageState();
}

class _FunctionPageState extends State<FunctionPage> {
  final List<String> _list = [
    '上传',
  ];

  void onClick(int index){
    String routeName = '';
    switch(index){
      case 0:
        routeName = '/upload';
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
            onTap: ()=> onClick(index),
            child: Container(
              height: 50,
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
