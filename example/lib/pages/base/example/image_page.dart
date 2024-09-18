

import 'package:example/pages/example_item.dart';
import 'package:example/pages/example_page.dart';
import 'package:flutter/material.dart';
import 'package:trade_hub/trade_hub.dart';

class ImagePage extends StatelessWidget {

  ImagePage({Key? key}) : super(key: key);

  final Font fontBodyMedium = Font(size: 20,lineHeight: 23);

  @override
  Widget build(BuildContext context) {
    return ExamplePage(
        title: 'Image 图片',
        children: [
          ExampleItem(
            title: "组件类型",
            widget: _imageCategory
          ),

          ExampleItem(title: "系统 Image", widget: Image.asset('assets/images/image.jpg'),)
        ],
    );
  }

  Widget get _imageCategory {

    return Wrap(
      children: [
        const SizedBox(
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: THText(
                '裁剪',
                font: fontBodyMedium,
                textColor: Colors.black38,
              ),
            ),
            const THImage(
              assetUrl: 'assets/images/image.jpg',
              type: THImageType.clip,
            ),
          ],
        ),
        const SizedBox(
          width: 24,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: THText(
                '适应高',
                font: fontBodyMedium,
                textColor: Colors.black38,
              ),
            ),
            Container(
              width: 89,
              height: 72,
              color: Colors.black,
              child: const THImage(
                assetUrl: 'assets/images/image.jpg',
                type: THImageType.fitHeight,
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 24,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: THText(
                '适应宽',
                font: fontBodyMedium,
                textColor: Colors.black38,
              ),
            ),
            Container(
              width: 89,
              height: 72,
              color: Colors.black,
              child: const THImage(
                assetUrl: 'assets/images/image.jpg',
                type: THImageType.fitWidth,
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 44,
        ),
        const SizedBox(
          width: 20,
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16, top: 20),
              child: THText(
                '拉伸',
                font: fontBodyMedium,
                textColor: Colors.black38,
              ),

            ),
            Container(
              color: Colors.black,
              width: 121,
              height: 72,
              child: const Stack(
                alignment: Alignment.center,
                children: [
                  THImage(
                    assetUrl: 'assets/images/image.jpg',
                    width: 121,
                    height: 50,
                    type: THImageType.stretch,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16, top: 20),
              child: THText(
                '方形圆角',
                font: fontBodyMedium,
                textColor: Colors.black38,
              ),

            ),

            const SizedBox(
              //color: Colors.black,
              width: 72,
              height: 72,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  THImage(
                    assetUrl: 'assets/images/image.jpg',
                    width: 72,
                    height: 72,
                    type: THImageType.roundedSquare,
                  ),
                ],
              ),
            ),
          ],
        ),


      ],
    );
  }

}