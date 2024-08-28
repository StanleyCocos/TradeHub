import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'action/action_page.dart';
import 'action/src/popup_page.dart';
import 'pages/base_page.dart';
import 'pages/show/avatar_page.dart';
import 'pages/show/countdown_page.dart';
import 'pages/show/show_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp (
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/base': (context) => const BasePage(),
        '/show': (context) => const ShowPage(),
        '/countdown': (context) => const CountdownPage(),
        '/avatar': (context) => const AvatarPage(),
        '/action': (context) => const ActionPage(),
        '/popup': (context) => const PopupPage(),
      },
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _list = ['基础', '交互', '展示', '插件'];

  Future _toPage(int index) async {
    String routeName = '';
    switch(index){
      case 0:
        routeName = '/base';
        break;
      case 1:
        routeName = '/action';
        break;
      case 2:
        routeName = '/show';
        break;
      default:
        routeName = '/base';
        break;
    }
    return await Get.toNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Trade Hub Design'),
      ),
      body: GridView.builder(
        itemCount: _list.length,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 每行有两个网格
          crossAxisSpacing: 10.0, // 网格之间的横向间距
          mainAxisSpacing: 10.0, // 网格之间的纵向间距
          childAspectRatio: 2.0,
        ),
        itemBuilder: (content, index) {
          return GestureDetector(
            onTap: ()=> _toPage(index),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(6),
              ),
              alignment: Alignment.center,
              child: Text(
                _list[index],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
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
