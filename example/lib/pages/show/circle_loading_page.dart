

import 'package:flutter/material.dart';
import 'package:trade_hub/trade_hub.dart';

class CircleLoadingPage extends StatelessWidget {
  const CircleLoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('圆形加载'),
      ),
      body: Column(
        children: [
          _item('默认', THCircleLoading()),
          _item('自定义颜色', const THCircleLoading(
            color: Colors.greenAccent,
          )),
          _item('自定义大小', const THCircleLoading(
            size: 50,
          )),
          _item('自定义粗细', const THCircleLoading(
            color: Colors.red,
            size: 50,
            strokeWidth: 5,
          )),
          _item('自定义转速', const THCircleLoading(
            size: 50,
            duration: 200,
          )),
        ],
      )
    );
  }

  Widget _item(String title, Widget widget) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            widget,
            const THDivider(
              margin: EdgeInsets.only(
                top: 20,
              ),
              isDashed: true,
            ),
          ],
        ));
  }
}