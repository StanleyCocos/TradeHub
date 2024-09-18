import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActionPage extends StatefulWidget {
  const ActionPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ActionState();
}

class _ActionState extends State<ActionPage> {
  final List<String> _list = [
    'popup',
  ];

  void onClick(int index) {
    String routeName = '';
    switch (index) {
      case 0:
        routeName = '/popup';
        break;
      case 1:
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
          return Divider(
            endIndent: 16,
            indent: 16,
            height: 1,
            color: Colors.grey.withOpacity(0.5),
            thickness: 1,
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
              child: Text(
                _list[index],
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
