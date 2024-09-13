import 'dart:io';
import 'dart:math';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiny_network/tiny_network.dart';
import 'package:trade_hub/src/base/base_controller.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:trade_hub/src/th_bottomsheet.dart';
import 'bean/image_upload_bean.dart';
import 'image_upload_model.dart';


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
      model.options = ["圖檔", "拍照", '從圖檔集選擇'];
    }
    model.initData.forEach((it) {
      model.upLoadList.add(ImageUploadBean(
        assets: it,
        resultUrl: it,
        upLoadType: UpLoadType.INITDATA,
        upImageType: UpImageType.NETWORK,
        key: '${DateTime.now().millisecondsSinceEpoch + Random().nextInt(999)}',
        describe: model.describe,
      ));
    });
    addMoreBean();
    notifyListeners();
  }

  ///创建新对象
  ImageUploadBean initNewBean({String? describe}) {
    return ImageUploadBean(
      key: '${DateTime.now().millisecondsSinceEpoch + Random().nextInt(999)}',
      upLoadType: UpLoadType.INIT,
      upImageType: UpImageType.ICON,
      describe: describe ?? model.describe,
    );
  }

  ///添加默认数据
  void addMoreBean() {
    if (model.upLoadList.length >= model.max) return;
    model.upLoadList.add(initNewBean());
  }

  ///选择上传方式
  void onImageTap(ImageUploadBean bean) {
    hideKeyboard();
    FBottomSheet.fBottomSheetOption(
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

  ///选择图片
  void selectImage(ImageSource source, ImageUploadBean bean) async {
    var file = await model.imagePicker?.getImage(source: source);
    if (file == null || file.runtimeType != PickedFile) return;
    bean.upLoadType = UpLoadType.UPING;
    bean.upImageType = UpImageType.FILE;
    bean.assets = File(file.path);
    uploadFile(bean);
  }

  ///删除图片
  void onCloseTap(ImageUploadBean bean) {
    model.upLoadList.removeWhere((element) => element.key == bean.key);
    bool hasInit = model.upLoadList.any(
      (it) => it.upLoadType == UpLoadType.INIT,
    );
    if (!hasInit) {
      addMoreBean();
    }
    onChanged();
    notifyListeners();
  }

  ///网络-上传图片
  void uploadFile(ImageUploadBean bean) async {
    model.onUploadProgress?.call(true);
    String url = model.uploadUrl ?? "";
    var param = model.uploadParam ?? {"type": model.netWorkType};
    if (bean.assets != null) {
      String fileName = "${bean.assets.path.split("/").last}";
      File? tempFile = bean.assets;
      if (model.isCompression != null && model.isCompression!) {
        tempFile = await ImageCompressUtil.getImageCompress(bean.assets);
      }
      param["image"] = await MultipartFile.fromFile(tempFile?.path ?? "",
          filename: fileName);
    }
    HttpRequest().postUpload(
      url,
      formData: param,
      progressCallBack: (int count, int total) {
        int progressValue = count * 100 ~/ total;
        bean.upLoadType = UpLoadType.UPING;
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
          bean.upLoadType = UpLoadType.SUCCESS;
          bean.resultUrl = url;
          addMoreBean();
          onChanged();
        } else {
          String message = data['message'];
          bean.upLoadType = UpLoadType.FAIL;
          addMoreBean();
          toast(message);
          notifyListeners();
        }
        notifyListeners();
      },
      errorCallBack: (error, code) {
        bean.upLoadType = UpLoadType.FAIL;
        addMoreBean();
        notifyListeners();
        toast('圖片上傳失敗');
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

