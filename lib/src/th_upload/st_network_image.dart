import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';


class STNetworkImage extends StatelessWidget {

  final String? imageUrl;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final Alignment alignment;
  final ImageRepeat repeat;
  final PlaceholderWidgetBuilder? placeholder;
  final LoadingErrorWidgetBuilder? errorWidget;
  final ImageWidgetBuilder? imageBuilder;

  STNetworkImage({
    required this.imageUrl,
    this.fit,
    this.placeholder,
    this.errorWidget,
    this.imageBuilder,
    this.width,
    this.height,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
  });

  @override
  Widget build(BuildContext context) {
    if(imageUrl == null || imageUrl == ""){
      Widget? widget = errorWidget?.call(context, _imageUrl, "");
      if(widget != null) return widget;
      return SizedBox(width: width, height: height,);
    }
    return CachedNetworkImage(
      imageUrl: _imageUrl,
      width: width,
      height: height,
      fit: fit,
      imageBuilder: imageBuilder,
      placeholder: placeholder,
      errorWidget: errorWidget,
    );
  }
}

extension Private on STNetworkImage {
  String get _imageUrl {
    return imageUrl ?? "";
    /*if(imageUrl != null && imageUrl!.startsWith("http")){
      return imageUrl!;
    }
    return Config.getTwImageUrl(imageUrl ?? "");*/
  }
}
