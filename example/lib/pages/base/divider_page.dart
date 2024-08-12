import 'package:flutter/material.dart';
import 'package:trade_hub/trade_hub.dart';

class DividerPage extends StatelessWidget {
  const DividerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('分割线'),
      ),
      body: const Center(
        child: Column(
          children: [
            SizedBox(height: 16),
            Text("水平分割线"),
            THDivider(),

            SizedBox(height: 16),
            Text("竖直分割线"),
            THDivider(
              height: 50,
              width: 1,
              color: Colors.red,
            ),

            SizedBox(height: 16),
            Text("水平虚线分割线"),
            THDivider(
              isDashed: true,
            ),

            SizedBox(height: 16),
            Text("竖直虚线分割线"),
            THDivider(
              height: 50,
              isDashed: true,
              direction: Axis.vertical,
            ),
          ],
        ),
      )
    );
  }

}