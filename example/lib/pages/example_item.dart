
import 'package:flutter/material.dart';
import 'package:trade_hub/trade_hub.dart';

class ExampleItem extends StatelessWidget {
  final String title;
  final Widget widget;
  final bool? isShowDivider;

  const ExampleItem({
    Key? key,
    required this.title,
    required this.widget,
    this.isShowDivider
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _item(title, widget);
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
              style: const TextStyle(fontSize: 20, color: Colors.black,height: 1.5),
            ),
            const SizedBox(
              height: 10,
            ),
            widget,
            Offstage(
              offstage: isShowDivider == null ? false : !isShowDivider!,
              child: const THDivider(
                margin: EdgeInsets.only(
                  top: 20,
                ),
                isDashed: true,
              ),
            ),
          ],
        ));
  }
}