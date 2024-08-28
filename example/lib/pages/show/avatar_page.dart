import 'package:flutter/material.dart';
import 'package:trade_hub/trade_hub.dart';

class AvatarPage extends StatefulWidget {
  const AvatarPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AvatarState();
}

class _AvatarState extends State<AvatarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('头像'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            _item(
              '圆形文字图片',
              '会展示一个圆形的头像，头像中间会显示白色文字',
              const THAvatar(
                text: "我是",
              ),
            ),
            const SizedBox(height: 20),
            _item(
              '圆形文字图片 自定义背景颜色, 带边框',
              '会展示一个圆形的头像，头像中间会显示白色文字',
              THAvatar(
                text: "Alice",
                backgroundColor: Colors.blue,
                border: Border.all(
                  color: Colors.red,
                  width: 2,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _item(
              '方形文字图片 自定义背景颜色',
              '会展示一个圆形的头像，头像中间会显示白色文字',
              const THAvatar(
                text: "Alice",
                shape: THAvatarShape.square,
                backgroundColor: Colors.blue,
              ),
            ),

            const SizedBox(height: 20),
            _item(
              '圆形文字图片 自定义背景颜色',
              '会展示一个圆形的头像，头像中间会显示白色文字',
              const THAvatar(
                text: "Alice",
                // shape: THAvatarShape.circle,
                backgroundColor: Colors.blue,
              ),
            ),

            const SizedBox(height: 20),
            _item(
              '圆形图片 自定义背景颜色, 带边框',
              '会展示一个圆形的头像',
              THAvatar(
                // text: "Alice",
                // shape: THAvatarShape.circle,
                url: 'http://e.hiphotos.baidu.com/image/pic/item/a1ec08fa513d2697e542494057fbb2fb4316d81e.jpg',
                backgroundColor: Colors.blue,
                border: Border.all(
                  color: Colors.red,
                  width: 10,
                )
              ),
            ),

            const SizedBox(height: 20),
            _item(
              '自定义大小方形图片',
              '会展示一个方形的头像',
              const THAvatar(
                // text: "Alice",
                size: 100,
                shape: THAvatarShape.square,
                url: 'http://e.hiphotos.baidu.com/image/pic/item/a1ec08fa513d2697e542494057fbb2fb4316d81e.jpg',
                backgroundColor: Colors.blue,
              ),
            ),

            const SizedBox(height: 20),
            _item(
              '自定义大小圆形形图片',
              '会展示一个圆形的头像',
              const THAvatar(
                // text: "Alice",
                size: 200,
                shape: THAvatarShape.circle,
                url: 'http://e.hiphotos.baidu.com/image/pic/item/a1ec08fa513d2697e542494057fbb2fb4316d81e.jpg',
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(String title, String text, Widget child) {
    return Row(
      children: [
        child,
         const SizedBox(width: 16,),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
