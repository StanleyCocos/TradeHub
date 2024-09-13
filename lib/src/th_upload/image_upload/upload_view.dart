import 'package:flutter/material.dart';

import 'bean/image_upload_bean.dart';
import 'st_network_image.dart';


class UploadView extends StatelessWidget {
  final ImageUploadBean bean;
  final double? size;
  final Function()? onImageTap;
  final Function()? onCloseTap;

  UploadView({
    required this.bean,
    this.size = 100,
    this.onImageTap,
    this.onCloseTap,
  });

  ///图片-视图
  Widget imageView() {
    Widget imageView;
    UpImageType upImageType = bean.upImageType;
    dynamic assets = bean.assets;

    if (upImageType == UpImageType.ICON) {
      imageView = Icon(
        Icons.camera_alt,
        size: 30,
        color: Colors.grey[400],
      );
    } else if (upImageType == UpImageType.NETWORK) {
      String path = bean.assets ?? '';
      imageView = STNetworkImage(
        imageUrl: path,
        fit: BoxFit.cover,
      );
    } else if (upImageType == UpImageType.FILE) {
      imageView = Image.file(assets, fit: BoxFit.cover);
    } else {
      imageView = Icon(
        Icons.camera_alt,
        size: 30,
        color: Colors.grey[400],
      );
    }
    return GestureDetector(
      onTap: _onImageTap,
      child: Container(
        height: size,
        width: size,
        // margin: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[100]!, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.white,
        ),
        alignment: Alignment.center,
        child: imageView,
      ),
    );
  }

  ///删除视图
  Widget deleteView() {
    Widget child;
    UpLoadType upLoadType = bean.upLoadType;
    if (upLoadType == UpLoadType.SUCCESS ||
        upLoadType == UpLoadType.FAIL ||
        upLoadType == UpLoadType.INITDATA) {
      child = InkWell(
        onTap: onCloseTap,
        child: Icon(
          Icons.cancel,
          size: 20,
          color: Colors.red,
        ),
      );
    } else {
      child = SizedBox.shrink();
    }
    return Positioned(top: 0, right: 0, child: child);
  }

  ///上传进度
  Widget uploadProgress() {
    String value = "";
    Color color = Colors.black87;
    UpLoadType upLoadType = bean.upLoadType;
    int progress = bean.progress ?? 0;
    if (upLoadType == UpLoadType.UPING) {
      if (progress == 100) {
        value = '上傳中';
      } else {
        value = '$progress %';
      }
      color = Colors.black87;
    } else if (upLoadType == UpLoadType.SUCCESS) {
      value = '上傳成功';
      color = Colors.green;
    } else if (upLoadType == UpLoadType.FAIL) {
      value = '上傳失敗';
      color = Colors.red;
    }

    if (value.length == 0) {
      return SizedBox.shrink();
    }
    return Container(
      child: Text(
        value,
        style: TextStyle(color: color),
      ),
    );
  }

  ///描述
  Widget describeView() {
    if (bean.describe == null) {
      return SizedBox.shrink();
    }
    if (bean.describe is Widget) {
      return bean.describe;
    }
    return Container(
      width: size,
      alignment: Alignment.center,
      child: Text(
        bean.describe,
        style: TextStyle(color: Colors.black87),
      ),
    );
  }

  ///图片与删除视图
  Widget imageAndDeleteView() {
    List<Widget> children = [];
    children.add(imageView());
    children.add(deleteView());
    return Stack(children: children);
  }

  @override
  Widget build(BuildContext context) {
    ///图片+删除+进度 视图
    List<Widget> children = [];
    children.add(imageAndDeleteView());
    children.add(describeView());
    children.add(uploadProgress());
    return Column(
      children: children,
      mainAxisSize: MainAxisSize.min,
    );
  }

  ///图片点击
  void _onImageTap() {
    if (bean.upLoadType != UpLoadType.INIT) return;
    onImageTap?.call();
  }
}
