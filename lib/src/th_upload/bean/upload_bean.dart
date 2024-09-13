import 'package:trade_hub/src/th_upload/upload_view.dart';

enum UpLoadState { INITDATA, INIT, UPING, SUCCESS, FAIL }

enum UpViewType { ICON, FILE, NETWORK }

class UploadBean {
  String? key;
  UpLoadState upLoadState;
  UpViewType upViewType;
  UpLoadType upLoadType;
  dynamic assets;
  int? progress;
  dynamic describe;
  String? resultUrl;

  UploadBean({
    this.key,
    this.upLoadState = UpLoadState.INIT,
    this.upViewType = UpViewType.FILE,
    this.upLoadType = UpLoadType.image,
    this.assets,
    this.progress,
    this.describe,
    this.resultUrl,
  });
}
