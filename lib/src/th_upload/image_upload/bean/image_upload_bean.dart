enum UpLoadType { INITDATA, INIT, UPING, SUCCESS, FAIL }

enum UpImageType { ICON, FILE, NETWORK }

class ImageUploadBean {
  String? key;
  UpLoadType upLoadType;
  UpImageType upImageType;
  dynamic assets;
  int? progress;
  dynamic describe;
  String? resultUrl;

  ImageUploadBean({
    this.key,
    this.upLoadType = UpLoadType.INIT,
    this.upImageType = UpImageType.FILE,
    this.assets,
    this.progress,
    this.describe,
    this.resultUrl,
  });
}
