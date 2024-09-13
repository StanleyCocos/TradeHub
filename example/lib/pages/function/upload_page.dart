import 'package:example/pages/example_item.dart';
import 'package:example/pages/example_page.dart';
import 'package:flutter/material.dart';
import 'package:trade_hub/trade_hub.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  @override
  Widget build(BuildContext context) {
    return ExamplePage(
      title: '上传插件',
      children: [ExampleItem(title: "图片上传", widget: _imageUpload)],
    );
  }

  Widget get _imageUpload {
    return ImageUploadView(
      max: 10,
      netWorkType: 'feedback',
      size: 160,
      onUploadProgress: onUploadProgress,
      onChanged: (List<String> list){
        print('图片上传结果：$list');
      },
      uploadUrl: 'https://mapi.debug.8591.com.tw/api/pub/upload',
    );
  }

  void onUploadProgress(bool value) {
    print('上传进度：$value');
  }
}
