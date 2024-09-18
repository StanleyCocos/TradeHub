import 'package:flutter/material.dart';
import 'package:trade_hub/trade_hub.dart';

class SwitchPage extends StatefulWidget {
  const SwitchPage({Key? key}) : super(key: key);

  @override
  State<SwitchPage> createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Switch 开关'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _item('普通开关', _normalSwitch),
            _item('文字开关', _textSwitch),
            _item('自定义颜色开关', _colorSwitch),
            _item('加载状态', _loadingSwitch),
            _item('禁用状态', _disableSwitch),
            _item('大尺寸', _largeSwitch),
            _item('中尺寸', _mediumSwitch),
            _item('小尺寸', _smallSwitch),
            _item('圆形指示器', _circleIndicator),
          ],
        ),
      ),
    );
  }

  Widget get _normalSwitch => const THSwitch();
  Widget get _textSwitch => const THSwitch(
        type: THSwitchType.text,
      );
  Widget get _colorSwitch => const THSwitch(
        trackOnColor: Colors.green,
      );
  Widget get _loadingSwitch => const THSwitch(
        isOn: true,
        type: THSwitchType.loading,
        trackOnColor: Colors.green,
      );
  Widget get _disableSwitch => const THSwitch(
        type: THSwitchType.loading,
        trackOnColor: Colors.green,
        enable: false,
      );
  Widget get _largeSwitch => const THSwitch(
        size: THSwitchSize.large,
      );
  Widget get _mediumSwitch => const THSwitch(
        size: THSwitchSize.medium,
      );
  Widget get _smallSwitch => const THSwitch(
        size: THSwitchSize.small,
      );
  Widget get _circleIndicator => const THCircleLoading(color: Color(0xFFED702D));

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
              isDashed: true,
            ),
          ],
        ));
  }
}
