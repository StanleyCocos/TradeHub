
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InteractionPage extends StatefulWidget {
  const InteractionPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InteractionPageState();
}

class _InteractionPageState extends State<InteractionPage> {
  final List<String> _list = [
    '单选',
  ];

  void onClick(int index){
    String routeName = '';
    switch(index){
      case 0:
        routeName = '/check_box';
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
