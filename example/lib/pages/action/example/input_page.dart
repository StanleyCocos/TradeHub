import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trade_hub/trade_hub.dart';

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  State createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            '输入框',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _item('普通输入框', _normalInput()),
              _item('', _normalLabelIconInput()),
              _item('', _normalLabelInput()),
              _item('竖向输入框', _columnInput()),
              _item('', _columnDecInput()),
            ],
          ),
        ));
  }

  /// 普通输入框
  Widget _normalInput() {
    return THInput(
      textAlign: TextAlign.start,
      showDivider: true,
      limitLabelStyle: const TextStyle(
        fontSize: 15,
        color: Color(0xFFBBBBBB),
      ),
      onLabelIconTap: () {
        print('点击了帮助图标');
      },
      hint: '请输入姓名',
    );
  }

  /// 普通输入框-labelIcon
  Widget _normalLabelIconInput() {
    return THInput(
      controller: controller..text = '123',
      labelTitle: '年龄',
      labelIcon: Icons.help_outline,
      isMust: true,
      onLabelIconTap: () {
        print('点击了帮助图标');
      },
      hint: '请输入年龄',
      keyboardType: TextInputType.number,
      limitAlign: THInputLimitAlign.tail,
      showLimitLabel: true,
      isCounter: true,
      showDivider: true,
      showClear: true,
      limitSuffix: '字',
      maxLength: 10,
      limitLabelStyle: const TextStyle(
        fontSize: 15,
        color: Color(0xFFBBBBBB),
      ),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly, // 只允许输入数字
      ],
    );
  }

  /// 普通输入框-自定义整个 label
  Widget _normalLabelInput() {
    return THInput(
      limitAlign: THInputLimitAlign.below,
      isCollapsed: true,
      showLimitLabel: true,
      isCounter: false, // 不显示计数器
      showDivider: true,
      showClear: true,
      limitSuffix: '字',
      maxLength: 10,
      limitLabelStyle: const TextStyle(
        fontSize: 15,
        color: Color(0xFFBBBBBB),
      ),
      label: Image.asset("assets/images/login_input_account.png",
          width: 20, height: 20, fit: BoxFit.cover),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly, // 只允许输入数字
      ],
      hint: '请输入账号',
      keyboardType: TextInputType.number,
    );
  }

  /// 竖向输入框
  Widget _columnInput() {
    return THInput(
      limitAlign: THInputLimitAlign.tail,
      showLimitLabel: true,
      isCounter: true,
      showDivider: true,
      //limitSuffix: '字',    // 限制标签后缀
      maxLength: 100,
      maxLines: 10,
      limitLabelStyle: const TextStyle(
        fontSize: 15,
        color: Color(0xFFBBBBBB),
      ),
      labelIconWidget: GestureDetector(
        onTap: () {
          print('点击了自定义图标');
        },
        child: Container(
            width: 22,
            height: 22,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 2),
            child: const Icon(
              Icons.edit_note,
              size: 20,
              color: Colors.blueAccent,
            )),
      ),
      textAlign: TextAlign.start,
      labelTitle: '姓名',
      hint: '请输入姓名',
      isMust: true,
      layoutType: THInputLayoutType.column, // 竖向布局
    );
  }

  Widget _columnDecInput() {
    return THInput(
      //controller: controller..text = '张三',
      height: 150,
      limitAlign: THInputLimitAlign.below,
      showLimitLabel: true,
      isCounter: true,
      showDivider: true,
      maxLines: 100,
      //limitSuffix: '字',
      // maxLines: 10,
      limitLabelStyle: const TextStyle(
        fontSize: 15,
        color: Color(0xFFBBBBBB),
      ),
      labelIconWidget: GestureDetector(
        onTap: () {
          print('点击了自定义图标');
        },
        child: Container(
            width: 22,
            height: 22,
            alignment: Alignment.center,
            // 这里显示偏上 特别调整一下
            padding: const EdgeInsets.only(top: 2),
            child: const Icon(
              Icons.edit_note,
              size: 20,
              color: Colors.blueAccent,
            )),
      ),
      textAlign: TextAlign.start,
      labelTitle: '姓名',
      hint: '请输入姓名',
      isMust: true,
      layoutType: THInputLayoutType.column,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Color(0xffD9D9D9),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Colors.orange,
            width: 1,
          ),
        ),
        hintText: "请输入姓名",
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        //isCollapsed: true,
        counterText: "",
      ),
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
            /*const THDivider(
              margin: EdgeInsets.only(
                top: 20,
              ),
              isDashed: true,
            ),*/
          ],
        ));
  }
}
