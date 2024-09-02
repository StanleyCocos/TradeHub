import 'package:flutter/material.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({
    Key? key,
    required this.children,
    this.title = 'Example Page',
    this.scrollController,
    this.floatingActionButton,
  }) : super(key: key);

  /// 页面标题
  final String title;

  /// 示例组件模块列表
  final List<Widget> children;

  /// 滚动控制组件
  final ScrollController? scrollController;

  /// 悬浮按钮
  final Widget? floatingActionButton;

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: widget.floatingActionButton,
        backgroundColor: const Color(0xFFF3F3F3),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
          controller: widget.scrollController,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 24, bottom: 24),
          itemCount: widget.children.length,
          itemBuilder: (BuildContext context, int index) {
            return widget.children[index];
          },
        ));
  }
}
