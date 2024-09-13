
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiny_network/tiny_network.dart';
import 'package:trade_hub/src/base/base_state_page.dart';
import 'package:trade_hub/src/th_provider_widget.dart';

import '../util/init_util.dart';
import 'upload_controller.dart';
import 'itme_upload_view.dart';

enum UpLoadType { image, file }

class ImageUploadView extends StatefulWidget {
  final double size;
  final int max;
  final List<String>? initData;
  final dynamic describe;
  final Function(List<String> value)? onChanged;

  final String? netWorkType;
  final String? uploadUrl;
  final Map<String, dynamic>? uploadParam;
  final bool? fromPicManage;
  final Function(Map map)? onResult;
  final Function(bool)? onUploadProgress;
  final double spacing;
  final double runSpacing;

  final UpLoadType upLoadType;

  //图片上传时是否压缩
  final bool isCompression;

  const ImageUploadView({super.key,
    required this.uploadUrl,
    this.upLoadType = UpLoadType.image,
    this.size = 100,
    this.max = 100,
    this.spacing = 0.0,
    this.runSpacing = 0.0,
    this.initData,
    this.describe,
    this.onChanged,
    this.netWorkType,
    this.uploadParam,
    this.fromPicManage = false,
    this.isCompression = true,
    this.onResult,
    this.onUploadProgress,
  });

  @override
  _ImageUploadViewState createState() => _ImageUploadViewState();
}

class _ImageUploadViewState
    extends BasePageState<ImageUploadView, ImageUploadController> {
  @override
  ImageUploadController controller = ImageUploadController();

  // @override
  // bool get isView => true;

  @override
  void initState() {
    initNetwork();
    controller.model.imagePicker = ImagePicker();
    controller.model.max = widget.max;
    controller.model.initData = widget.initData ?? [];
    controller.model.describe = widget.describe;
    controller.model.onChanged = widget.onChanged;
    controller.model.onUploadProgress = widget.onUploadProgress;
    controller.model.netWorkType = widget.netWorkType;
    controller.model.uploadUrl = widget.uploadUrl;
    controller.model.uploadParam = widget.uploadParam;
    controller.model.fromPicManage = widget.fromPicManage;
    controller.model.onResult = widget.onResult;
    controller.model.isCompression = widget.isCompression;
    controller.model.upLoadType = widget.upLoadType;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    controller.context = context;
    return THProviderWidget(controller: controller, builder: ()=> content);
  }

  @override
  Widget get content {
    List<Widget> children = [];
    controller.model.upLoadList.forEach(
      (element) {
        children.add(
          UploadView(
            bean: element,
            size: widget.size,
            onImageTap: () => controller.onItemViewTap(element),
            onCloseTap: () => controller.onCloseTap(element),
          ),
        );
      },
    );
    return Container(
      child: Wrap(
        children: children,
        spacing: widget.spacing,
        runSpacing: widget.runSpacing,
        alignment: WrapAlignment.start,
      ),
    );
  }

}
