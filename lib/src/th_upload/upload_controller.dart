import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiny_network/tiny_network.dart';
import 'package:trade_hub/src/base/base_controller.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:trade_hub/src/th_bottomsheet.dart';
import 'package:trade_hub/trade_hub.dart';
import 'bean/upload_bean.dart';
import 'upload_model.dart';

typedef BuildUploadRequestParams = Map<String, dynamic> Function(
    UploadBean bean, String url, Map<String, dynamic> param, String fileName, File? file);

class ImageUploadController extends BaseController<ImageUploadModel> {



  @override
  ImageUploadModel model = ImageUploadModel();

  @override
  bool get content => true;

  @override
  void widgetDidLoad() {
    initData();
  }

  ///初始化
  void initData() {
    if (model.fromPicManage != null && model.fromPicManage!) {
      model.options = ["圖檔", "拍照"];
    }
    model.initData.forEach((it) {
      model.upLoadList.add(UploadBean(
        assets: it,
        resultUrl: it,
        upLoadState: UpLoadState.INITDATA,
        upViewType: UpViewType.NETWORK,
        upLoadType: model.upLoadType,
        key: '${DateTime.now().millisecondsSinceEpoch + Random().nextInt(999)}',
        describe: model.describe,
      ));
    });
    addMoreBean();
    notifyListeners();
  }

  ///创建新对象
  UploadBean initNewBean({String? describe}) {
    return UploadBean(
      key: '${DateTime.now().millisecondsSinceEpoch + Random().nextInt(999)}',
      upLoadState: UpLoadState.INIT,
      upViewType: UpViewType.ICON,
      upLoadType: model.upLoadType,
      describe: describe ?? model.describe,
    );
  }

  ///添加默认数据
  void addMoreBean() {
    if (model.upLoadList.length >= model.max) return;
    model.upLoadList.add(initNewBean());
  }

  ///选择上传方式
  void onItemViewTap(UploadBean bean) {
    hideKeyboard();
    switch (model.upLoadType) {
      case UpLoadType.image:
        onImageTap(bean);
        break;
      case UpLoadType.file:
        onFileTap(bean);
        break;
    }
  }

  ///选择图片
  void selectImage(ImageSource source, UploadBean bean) async {
    var file = await model.imagePicker?.getImage(source: source);
    if (file == null || file.runtimeType != PickedFile) return;
    bean.upLoadState = UpLoadState.UPING;
    bean.upViewType = UpViewType.FILE;
    bean.assets = File(file.path);
    uploadFile(bean);
  }

  ///删除图片
  void onCloseTap(UploadBean bean) {
    model.upLoadList.removeWhere((element) => element.key == bean.key);
    bool hasInit = model.upLoadList.any(
      (it) => it.upLoadState == UpLoadState.INIT,
    );
    if (!hasInit) {
      addMoreBean();
    }
    onChanged();
    notifyListeners();
  }

  ///网络-上传图片
  void uploadFile(UploadBean bean) async {
    model.onUploadProgress?.call(true);
    String url = model.uploadUrl ?? "";
    var param = model.uploadParam ?? {"type": model.netWorkType};
    if (bean.assets != null) {
      String fileName = "${bean.assets.path.split("/").last}";
      File? tempFile = bean.assets;
      if (bean.upLoadType == UpLoadType.image &&
          model.isCompression != null &&
          model.isCompression!) {
        tempFile = await ImageCompressUtil.getImageCompress(bean.assets);
      }
      if(model.onBuildParams != null){
        param = model.onBuildParams!.call(bean, url, param, fileName, tempFile);
      }else {
        MultipartFile multipartFile = await MultipartFile.fromFile(tempFile?.path ?? "",
            filename: fileName);
        switch(bean.upLoadType){
          case UpLoadType.image:
            param["image"] = multipartFile;
            break;
          case UpLoadType.file:
            param["file"] = multipartFile;
            break;
        }
      }
    }
    HttpRequest().postUpload(
      url,
      formData: param,
      progressCallBack: (int count, int total) {
        int progressValue = count * 100 ~/ total;
        bean.upLoadState = UpLoadState.UPING;
        bean.progress = progressValue;
        notifyListeners();
      },
      callBack: (data) {
        if (model.onResult != null) {
          model.onResult?.call(data);
        }
        int code = data['code'];
        var tempData = data['data'];
        if (code == 200 || (code != 200 && tempData != null)) {
          String url = data['data']['uri'];
          bean.upLoadState = UpLoadState.SUCCESS;
          bean.resultUrl = url;
          addMoreBean();
          onChanged();
        } else {
          String message = data['message'];
          bean.upLoadState = UpLoadState.FAIL;
          addMoreBean();
          toast(message);
          notifyListeners();
        }
        notifyListeners();
      },
      errorCallBack: (error, code) {
        bean.upLoadState = UpLoadState.FAIL;
        addMoreBean();
        notifyListeners();
        toast('上傳失敗');
      },
      commonCallBack: () {
        model.onUploadProgress?.call(false);
      },
    );
  }

  void onChanged() {
    if (model.onChanged != null) {
      List<String> temp = [];
      model.upLoadList.forEach((it) {
        if (it.resultUrl != null) {
          temp.add(it.resultUrl!);
        }
      });
      model.onChanged?.call(temp);
    }
  }

  ///图片选择
  void onImageTap(UploadBean bean) {
    THBottomSheet.bottomSheetOption(
      context,
      option: model.options,
      onSelect: (int index, String value) {
        if (index == 0) {
          //EventAnalytics.onEvent(page: '免费刊登', model: '刊登页2', event: '从手机相册选择');
          selectImage(ImageSource.gallery, bean);
        } else if (index == 1) {
          //EventAnalytics.onEvent(page: '免费刊登', model: '刊登页2', event: '从手机相册选择');
          selectImage(ImageSource.camera, bean);
        }
      },
    );
  }

  ///文件选择
  void onFileTap(UploadBean bean) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    print("result: $result");
    if (result == null) return;
    String path = result.paths.firstOrNull ?? '';
    if (path.isEmpty) return;
    bean.upLoadState = UpLoadState.UPING;
    bean.upViewType = UpViewType.FILE;
    bean.assets = File(path);

    uploadFile(bean);
  }
}

///图片压缩
class ImageCompressUtil {
  static Future<File?> getImageCompress(File file) async {
    String fileName = "${file.path.split("/").last}";

    final dir = await path_provider.getTemporaryDirectory();
    String targetPath = "${dir.absolute.path}/$fileName.jpg";
    return FlutterImageCompress.compressAndGetFile(
      file.path,
      targetPath,
      quality: 50,
    );
  }
}
