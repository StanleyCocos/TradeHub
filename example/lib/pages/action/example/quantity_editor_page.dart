

import 'package:flutter/material.dart';
import 'package:trade_hub/trade_hub.dart';

class QuantityEditorPage extends StatelessWidget {
  const QuantityEditorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('数量编辑器'),
      ),
      body: Center(
        child: THQuantityEditor(
          count: 1,
          min: 1,
          max: 99,
          onChanged: (number) {
            print('number: $number');
          },
        ),
      ),
    );
  }
}


