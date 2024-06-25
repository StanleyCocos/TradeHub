import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() => _BasePageState();

}

class _BasePageState extends State<BasePage> {

  final List<String> _list = [
    '',
  ];
  var value = 0.obs;
  final StreamController<int>  _streamController = StreamController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('基础'),),
      body: Column(
        children: [

          ElevatedButton(onPressed: (){
            // value++;
            // _streamController.add(value);
            value += 1;

          }, child: Text("click")),
          stream(value),
          // _build,


        ],
      ),
    );
  }


  Widget stream(RxInt value) {
    return Obx(() => Text('$value'));


    return StreamBuilder(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        print("StreamBuilder");
        if (snapshot.hasData) {
          return Text('Data: ${snapshot.data}');
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  // Widget get _build {
  //   return FutureBuilder(
  //     future: fetchData(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return CircularProgressIndicator();
  //       } else if (snapshot.hasError) {
  //         return Text('Error: ${snapshot.error}');
  //       } else {
  //         return Text('Data: ${snapshot.data}');
  //       }
  //     },
  //   );
  // }

}