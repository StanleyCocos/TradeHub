import 'dart:io';
import 'package:flutter/material.dart';
import 'package:trade_hub/src/th_text/th_text.dart';
import 'package:trade_hub/src/th_upload/upload_view.dart';
import 'package:trade_hub/trade_hub.dart';

import 'bean/upload_bean.dart';
import '../th_image/th_network_image.dart';

class UploadView extends StatelessWidget {
  final UploadBean bean;
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
    UpViewType upImageType = bean.upViewType;
    dynamic assets = bean.assets;

    if (upImageType == UpViewType.ICON) {
      imageView = Icon(
        Icons.camera_alt,
        size: 30,
        color: Colors.grey[400],
      );
    } else if (upImageType == UpViewType.NETWORK) {
      String path = bean.assets ?? '';
      imageView = THImage(
        imgUrl: path,
        fit: BoxFit.cover,
      );
    } else if (upImageType == UpViewType.FILE) {
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

  ///文件视图
  Widget fileView() {
    Widget imageView;
    UpViewType upViewType = bean.upViewType;
    dynamic assets = bean.assets;
    String fileName = "";
    if (bean.assets != null && bean.assets is File) {
      fileName = "${bean.assets.path.split("/").last}";
    }

    if (upViewType == UpViewType.ICON) {
      imageView = Icon(
        Icons.add,
        size: 30,
        color: Colors.grey[400],
      );
    } else if (upViewType == UpViewType.FILE ||
        upViewType == UpViewType.NETWORK) {
      imageView = Icon(
        Icons.file_present_rounded,
        size: 30,
        color: Colors.grey[400],
      );
    } else {
      imageView = Icon(
        Icons.add,
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
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: imageView,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Offstage(
                offstage: fileName.isEmpty,
                child: THText(
                  fileName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///删除视图
  Widget deleteView() {
    Widget child;
    UpLoadState upLoadType = bean.upLoadState;
    if (upLoadType == UpLoadState.SUCCESS ||
        upLoadType == UpLoadState.FAIL ||
        upLoadType == UpLoadState.INITDATA) {
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
    UpLoadState upLoadType = bean.upLoadState;
    int progress = bean.progress ?? 0;
    if (upLoadType == UpLoadState.UPING) {
      if (progress == 100) {
        value = '上傳中';
      } else {
        value = '$progress %';
      }
      color = Colors.black87;
    } else if (upLoadType == UpLoadState.SUCCESS) {
      value = '上傳成功';
      color = Colors.green;
    } else if (upLoadType == UpLoadState.FAIL) {
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
    if (bean.upLoadType == UpLoadType.file) {
      children.add(fileView());
    } else {
      children.add(imageView());
    }
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
    if (bean.upLoadState != UpLoadState.INIT) return;
    onImageTap?.call();
  }
}
