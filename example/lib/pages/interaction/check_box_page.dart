import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trade_hub/trade_hub.dart';

class CheckBoxPage extends StatefulWidget {
  const CheckBoxPage({Key? key}) : super(key: key);

  @override
  _CheckBoxPageState createState() => _CheckBoxPageState();
}

class _CheckBoxPageState extends State<CheckBoxPage> {
  List<String> items = [
    '复选框1',
    '复选框2',
    '复选框3',
    '复选框4',
    '复选框5',
  ];

  List<Test> testObjectList = [
    Test(),
    Test(),
    Test(),
    Test(),
  ];

  final THCheckBoxController _controller = THCheckBoxController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            '复选框/单选框',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //横向弹性复选框
              _item('横向弹性复选框', _horizontalCheckBox()),
              _item('竖直复选框', _verticalCheckBox()),
              _item('横向单选框', _horizontalRadio()),
              _item('竖直单选框', _verticalRadio()),
            ],
          ),
        ));
  }

  /// 横向弹性复选框
  Widget _horizontalCheckBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        THCheckBox(
          controller: _controller,
          itemList: testObjectList,
          direction: THCheckBoxDirection.horizontal,
          spacing: 20,
          runSpacing: 30,
          onClickCheckChanged: (List<Test> checkedList, int index, bool isCheck) {
            print("checkedList:$checkedList, index:$index, isCheck:$isCheck");
          },
          itemBuilder: (BuildContext context, int index, Test item, bool isCheck) {
            return THCheckboxItem(
              title: '复选框${item.name}',
              checked: isCheck,
            );
          },
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            TextButton(onPressed: () {
              _controller.toggle(1, true);
            }, child: const Text("单选 2")),

            TextButton(onPressed: () {
              _controller.toggleAll(true);
            }, child: const Text("全选")),

            TextButton(onPressed: () {
              _controller.toggleAll(false);
            }, child: const Text("全不选")),

            TextButton(onPressed: () {
              _controller.reverseAll();
            }, child: const Text("反选")),

            TextButton(onPressed: () {
              List list = _controller.allChecked();
              print("选中的值:$list");
            }, child: const Text("获取选中的值")),

          ],
        ),
      ],
    );
  }

  /// 竖直列表复选框
  Widget _verticalCheckBox() {
    return THCheckBox(
      itemList: testObjectList,
      direction: THCheckBoxDirection.vertical,
      spacing: 20,
      runSpacing: 30,
      onClickCheckChanged: (List<Test> checkedList, int index, bool isCheck) {
        print("checkedList:$checkedList, index:$index, isCheck:$isCheck");
      },
      itemBuilder: (BuildContext context, int index, Test item, bool isCheck) {
        return THCheckboxItem(
          title: '复选框${item.name}',
          checked: isCheck,
        );
      },
    );
  }

  /// 横向单选框
  Widget _horizontalRadio() {
    return Column(
      children: [
        THCheckBox(
          itemList: testObjectList,
          direction: THCheckBoxDirection.horizontal,
          type: THCheckBoxType.radio,
          spacing: 20,
          runSpacing: 30,
          onClickCheckChanged: (List<Test> checkedList, int index, bool isCheck) {
            print("checkedList:$checkedList, index:$index, isCheck:$isCheck");
          },
          itemBuilder:
              (BuildContext context, int index, Test item, bool isCheck) {
            return THCheckboxItem(
              title: '复选框${item.name}',
              checked: isCheck,
            );
          },
        ),

      ],
    );
  }

  /// 竖直单选框
  Widget _verticalRadio() {
    return THCheckBox(
      itemList: testObjectList,
      direction: THCheckBoxDirection.vertical,
      type: THCheckBoxType.radio,
      spacing: 20,
      runSpacing: 30,
      onClickCheckChanged: (List<Test> checkedList, int index, bool isCheck) {
        print("checkedList:$checkedList, index:$index, isCheck:$isCheck");
      },
      itemBuilder: (BuildContext context, int index, Test item, bool isCheck) {
        return THCheckboxItem(
          title: '复选框${item.name}',
          checked: isCheck,
        );
      },
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
            ),
          ],
        ));
  }
}

class Test {
  String name = "hh";
  String age = "11";
}
