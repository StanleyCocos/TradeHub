


import 'package:example/pages/example_item.dart';
import 'package:example/pages/example_page.dart';
import 'package:flutter/material.dart';
import 'package:trade_hub/trade_hub.dart';

class TextPage extends StatelessWidget{
  const TextPage({Key? key}) : super(key: key);

  final exampleTxt = '文本Text';

  @override
  Widget build(BuildContext context) {
    return ExamplePage(
        title: 'Text 文本',
        children: [
          ExampleItem(
            title: "普通文本",
            widget: _buildNormalTHText,
          ),

          ExampleItem(
            title: "指定常用属性",
            widget: _buildGeneralProp,
          ),

          ExampleItem(
            title: "style覆盖textColor",
            widget: _buildStyleCoverColor,
          ),

          ExampleItem(
            title: "style覆盖textColor和font",
            widget: _buildStyleCoverColorAndFont,
          ),

          ExampleItem(
            title: "TDText.rich测试:",
            widget: _buildRichText,
          ),

          ExampleItem(
            title: "中文居中:（带有英文可能不居中）",
            widget: _buildVerticalCenterText,
          ),

          ExampleItem(
            title: "自定义内部padding:",
            widget: _buildCustomPaddingText,
          ),
        ],
    );
  }

  Widget get _buildNormalTHText {
    return THText(
      exampleTxt,
    );
  }

  Widget get _buildGeneralProp {
    return THText(
      exampleTxt,
      font: Font(
        size: 16,
        lineHeight: 30,
        fontWeight: FontWeight.bold,
      ),
      textColor: Colors.red,
      backgroundColor: Colors.black,
    );
  }

  Widget get _buildStyleCoverColor {
    return THText(
      exampleTxt,
      textColor: Colors.green,
      style: const TextStyle(
        color: Colors.yellow,
      ),
    );
  }

  Widget get _buildStyleCoverColorAndFont {
    return THText(
      exampleTxt,
      textColor: Colors.green,
      font: Font(
        size: 16,
        lineHeight: 30,
        fontWeight: FontWeight.bold,
      ),
      style: const TextStyle(
        color: Colors.yellow,
      ),
    );
  }

  Widget get _buildRichText {
    return THText.rich(
      TextSpan(
        children: [
          THTextSpan(
            text: 'THTextSpan1',
            font: Font(
              size: 16,
              lineHeight: 30,
              fontWeight: FontWeight.bold,
            ),
            textColor: Colors.red,
            isTextThrough: true,
            lineThroughColor: Colors.blue,
          ),

          THTextSpan(
            text: 'THTextSpan2',
            font: Font(
              size: 10,
              lineHeight: 30,
              fontWeight: FontWeight.bold,
            ),
            textColor: Colors.green,
            lineThroughColor: Colors.black,
          ),

          THTextSpan(
            text: 'THTextSpan3',

          )
        ]
      ),
      style:
      const TextStyle(color: Colors.amber
          , fontSize: 32),
      backgroundColor: Colors.grey,
    );
  }

  Widget get _buildVerticalCenterText {
    return const THText(
      '中华人民共和国腾讯科技',
      // font: Font(size: 100, lineHeight: 100),
      forceVerticalCenter: true,
      backgroundColor: Colors.grey,
    );
  }

  Widget get _buildCustomPaddingText {
    return THTextConfiguration(
      paddingConfig: CustomTextPaddingConfig(),
      child: const CustomPaddingText(),
    );
  }
}

/// 自定义控件，内部的context可拿到外部TDTextConfiguration的配置信息
class CustomPaddingText extends StatelessWidget {
  const CustomPaddingText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const THText(
          '中华人民共和国腾讯科技fgjpqy',
          forceVerticalCenter: true,
          backgroundColor: Colors.grey,
        ),
        THText(
          'English',
          font: Font(
            size: 100,
            lineHeight: 100,
          ),
          forceVerticalCenter: true,
          backgroundColor: Colors.greenAccent,
        ),
      ],
    );
  }
}

/// 重写内部padding方法
class CustomTextPaddingConfig extends THTextPaddingConfig {
  @override
  EdgeInsetsGeometry getPadding(String? data, double fontSize, double height) {
    var supperPadding = super.getPadding(data, fontSize, height);
    return EdgeInsets.only(left: 40, top: supperPadding.vertical.toDouble());
  }
}