import 'package:image_picker/image_picker.dart';
import 'package:trade_hub/src/base/base_model.dart';

import 'bean/image_upload_bean.dart';

class ImageUploadModel extends BaseModel {
  ImagePicker? imagePicker;
  List<String> options = ["圖檔", "拍照"];
  List<ImageUploadBean> upLoadList = [];

  int max = 0;
  List<String> initData = [];
  dynamic describe;
  Function(List<String> value)? onChanged;

  String? netWorkType;
  String? uploadUrl;
  Map<String, dynamic>? uploadParam;
  bool? fromPicManage;
  Function(Map map)? onResult;
  Function(bool)? onUploadProgress;
  bool? isCompression;
  int uploadFinishState = 0;
}
