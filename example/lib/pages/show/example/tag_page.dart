import 'package:example/pages/example_item.dart';
import 'package:example/pages/example_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trade_hub/trade_hub.dart';

class TagPage extends StatelessWidget {
  const TagPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExamplePage(
      title: "标签",
      children: [
        ExampleItem(
          title: "基础标签",
          widget: Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              _buildSimpleFillTag(),
              const SizedBox(
                width: 16,
              ),
              _buildSimpleOutlineTag(),
            ],
          ),
        ),
        ExampleItem(
          title: "半圆标签",
          widget: Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              _buildCircleFillTag(),
              const SizedBox(
                width: 16,
              ),
              _buildCircleOutlineTag(),
            ],
          ),
        ),

        ExampleItem(
          title: "Mark标签",
          widget: Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              _buildMarkFillTagLeft(),
              const SizedBox(
                width: 16,
              ),
              _buildMarkFillTagRight(),
               const SizedBox(
                width: 16,
              ),
              _buildMarkOutlineTagLeft(),
              const SizedBox(
                width: 16,
              ),
              _buildMarkOutlineTagRight(),

            ],
          ),
        ),

        ExampleItem(title: "带图标", widget: Row(
          children: [
            const SizedBox(
              width: 16,
            ),
            _buildIconFillTag(),
            const SizedBox(
              width: 16,
            ),
            _buildIconOutlineTag(),
          ],
        )),

        ExampleItem(title: "预设尺寸", widget: _buildAllSizeTags()),

        ExampleItem(title: "自定义尺寸", widget: _buildCustomSizeTags()),


      ],
    );
  }

  Widget _buildCustomSizeTags() {
    return Wrap(spacing: 8, children: [
      THTag(
        '自定义尺寸',
        font: Font(size: 20, lineHeight: 30),
        textColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      THTag(
        '自定义尺寸-加粗',
        font: Font(size: 15, lineHeight: 30),
        fontWeight: FontWeight.bold,
        textColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: THTag(
          '自定义尺寸-padding',
          font: Font(size: 12, lineHeight: 20),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          fontWeight: FontWeight.bold,
          textColor: Colors.white,
          backgroundColor: Colors.blue,
        ),
      ),
    ]);
  }

  Widget _buildAllSizeTags() {
    return const Wrap(spacing: 8, children: [
      THTag(
        '加大尺寸',
        size: THTagSize.extraLarge,
        textColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      THTag(
        '大尺寸',
        size: THTagSize.large,
        textColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      THTag(
        '中尺寸',
        size: THTagSize.medium,
        textColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      THTag(
        '小尺寸',
        size: THTagSize.small,
        textColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
    ]);
  }


  Widget _buildIconFillTag() {
    return const THTag(
      '标签文字',
      icon: Icons.discount,
      textColor: Colors.white,
      backgroundColor: Colors.blue,
    );
  }

  Widget _buildIconOutlineTag() {
    return const THTag(
      '标签文字',
      icon: Icons.discount,
      textColor: Colors.blue,
      borderColor: Colors.blue,
    );
  }

  Widget _buildMarkFillTagLeft() {
    return const THTag(
      '标签文字',
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      shape: THTagShape.leftRound,
    );
  }

  Widget _buildMarkFillTagRight() {
    return const THTag(
      '标签文字',
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      shape: THTagShape.rightRound,
    );
  }

  Widget _buildMarkOutlineTagLeft() {
    return const THTag(
      '标签文字',
      shape: THTagShape.leftRound,
      textColor: Colors.blue,
      borderColor: Colors.blue,
    );
  }

  Widget _buildMarkOutlineTagRight() {
    return const THTag(
      '标签文字',
      shape: THTagShape.rightRound,
      textColor: Colors.blue,
      borderColor: Colors.blue,
    );
  }



  Widget _buildCircleFillTag() {
    return const THTag(
      '标签文字',
      backgroundColor: Colors.blue,
      shape: THTagShape.round,
      borderColor: Colors.blue,
    );
  }

  Widget _buildCircleOutlineTag() {
    return const THTag(
      '标签文字',
      shape: THTagShape.round,
      textColor: Colors.blue,
      borderColor: Colors.blue,
    );
  }

  Widget _buildSimpleFillTag() {
    return const THTag(
      '标签文字',
      backgroundColor: Colors.blue,
    );
  }

  Widget _buildSimpleOutlineTag() {
    return const THTag(
      '标签文字',
      border: 1,
      textColor: Colors.blue,
      borderColor: Colors.blue,
    );
  }
}
