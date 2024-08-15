import 'package:flutter/cupertino.dart';
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
    Test(name: "恶魔杀手"),
    Test(name: "狂暴战士"),
    Test(name: "提莫队长"),
    Test(name: "狂野女猎手"),
    Test(name: "欧巴马"),
    Test(name: "剑圣"),
    Test(name: "狂战士"),
    Test(name: "悠米冲冲冲虫"),
  ];

  /// 复选框控制器
  final THCheckBoxController _checkBoxController = THCheckBoxController();
  /// 单选框控制器
  final THCheckBoxController _radioBoxController = THCheckBoxController();
  /// 单选框是否支持取消
  bool radioAllowCancel = false;


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
          controller: _checkBoxController,
          itemList: testObjectList,
          checkedList: [Test(name: "提莫队长"),Test(name: "狂战士")],  //默认选中， 不是同一对象引用，需要重写itemCompare比较方法，默认 == 比较
          direction: THCheckBoxDirection.horizontal,
          radioAllowCancel: radioAllowCancel,   // 单选是否支持取消
          spacing: 20,
          runSpacing: 20,
          itemCompare: (Test a, Test b) {     // 重写比较方法， 不重写默认是 == 比较
            return a.name == b.name;
          },
          onClickCheckChanged: (List<Test> checkedList, int index, bool isCheck) {
            //点击选中状态改变回调，只有手动点击才会回调，通过控制器操作不会回调

          },
          itemBuilder: (BuildContext context, int index, Test item, bool isCheck) {
            // 构建 item 视图，可自定义视图
            return THCheckboxItem(
              title: item.name,
              checked: isCheck,
            );
          },
        ),

        const SizedBox(height: 20,),

        const Text(
          "控制器操作:",
          style: TextStyle(
            fontSize: 15,
            color: Colors.red,
          )
        ),
        Wrap(
          children: [
            TextButton(onPressed: () {
              _checkBoxController.toggle(1, true);
            }, child: const Text("选中第2个")),

            TextButton(onPressed: () {
              _checkBoxController.toggleAll(true);
            }, child: const Text("全选")),

            TextButton(onPressed: () {
              _checkBoxController.toggleAll(false);
            }, child: const Text("全不选")),

            TextButton(onPressed: () {
              _checkBoxController.reverseAll();
            }, child: const Text("反选")),

            TextButton(onPressed: () {
              List list = _checkBoxController.allChecked();
              print("选中的值:$list");
            }, child: const Text("获取选中的值")),

          ],
        ),

        const THDivider(
            isDashed: true,
          margin: EdgeInsets.symmetric(vertical: 10),
        ),

        const Text(
          "自定义视图：",
          style: TextStyle(
            fontSize: 17,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        /// 自定义视图
        THCheckBox(
          itemList: testObjectList,
          checkedList: [testObjectList[0],testObjectList[2]],  //默认选中， 不是同一对象引用，需要重写itemCompare比较方法，默认 == 比较
          direction: THCheckBoxDirection.horizontal,
          radioAllowCancel: radioAllowCancel,
          spacing: 20,
          runSpacing: 20,
          itemCompare: (Test a, Test b) {     // 重写比较方法， 不重写默认是 == 比较
            return a.name == b.name;
          },
          itemBuilder: (BuildContext context, int index, Test item, bool isCheck) {
            // 构建 item 视图，可自定义视图
            return Container(
              decoration: BoxDecoration(
                color: Color(isCheck ? 0xffffefe6 : 0xFFF2F3F5),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                item.name,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(isCheck ? 0xfffc7332 : 0xFF1D2129),
                ),
              ),
            );
          },
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
      runSpacing: 20,
      onClickCheckChanged: (List<Test> checkedList, int index, bool isCheck) {
        print("checkedList:$checkedList, index:$index, isCheck:$isCheck");
      },
      itemBuilder: (BuildContext context, int index, Test item, bool isCheck) {
        return THCheckboxItem(
          title: ''
              '${item.name}',
          checked: isCheck,
        );
      },
    );
  }

  /// 横向单选框
  Widget _horizontalRadio() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        THCheckBox(
          controller: _radioBoxController,
          itemList: testObjectList,
          direction: THCheckBoxDirection.horizontal,
          type: THCheckBoxType.radio,
          radioAllowCancel: radioAllowCancel,
          spacing: 20,
          runSpacing: 20,
          itemCompare: (Test a, Test b) {
            print("itemCompare a:$a, b:$b");
            return a == b;
          },
          onCheckChanged: (List<Test> checkedList) {
            print("checkedList:$checkedList");
          },
          onClickCheckChanged: (List<Test> checkedList, int index, bool isCheck) {
            print("checkedList:$checkedList, index:$index, isCheck:$isCheck");
          },
          itemBuilder:
              (BuildContext context, int index, Test item, bool isCheck) {
            return THCheckboxItem(
              title: item.name,
              checked: isCheck,
            );
          },
        ),

        Row(
          children: [
            TextButton(onPressed: () {
              _radioBoxController.toggle(1, true);
            }, child: const Text("选中第2个")),

            TextButton(onPressed: () {
              List list = _radioBoxController.allChecked();
              print("选中的值:$list");
            }, child: const Text("获取选中的值")),

            TextButton(onPressed: () {
              radioAllowCancel = !radioAllowCancel;
              setState(() {});
            }, child: Text(radioAllowCancel ? '可取消' : '不可取消')),



            TextButton(onPressed: () {
              _radioBoxController.reset();
            }, child: const Text("重置选项")),

          ],
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
      runSpacing: 20,
      onClickCheckChanged: (List<Test> checkedList, int index, bool isCheck) {
        print("checkedList:$checkedList, index:$index, isCheck:$isCheck");
      },
      itemBuilder: (BuildContext context, int index, Test item, bool isCheck) {
        return THCheckboxItem(
          title: item.name,
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
  String name = "杀手";
  String age = "11";
  Test({this.name = "杀手", this.age = "11"});
}
