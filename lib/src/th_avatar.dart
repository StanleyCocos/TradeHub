import 'package:flutter/material.dart';

enum THAvatarShape {
  circle,
  square,
}

const double _defaultSize = 60;

abstract class _THAvatar extends StatelessWidget {

  /// 网络图片地址
  final String? url;

  /// 头像大小
  final double? size;

  /// 圆角大小(square时生效)
  final double? radius;

  /// 头像形状
  final THAvatarShape? shape;

  /// 背景颜色
  final Color? backgroundColor;

  /// 文字
  final String? text;

  final BoxBorder? border;

  const _THAvatar({
    Key? key,
    this.shape = THAvatarShape.circle,
    this.url,
    this.size,
    this.radius,
    this.text,
    this.backgroundColor,
    this.border,
  }) : super(key: key);
}

class THAvatar extends _THAvatar {
  const THAvatar.circle({
    super.key,
    super.size,
    super.url,
    super.text,
    super.border,
    super.backgroundColor,
    super.shape = THAvatarShape.circle,
  });

  const THAvatar.square({
    super.key,
    super.size,
    super.url,
    super.text,
    super.border,
    super.backgroundColor,
    super.shape = THAvatarShape.square,
  });

  const THAvatar({
    super.key,
    super.url,
    super.size,
    super.text,
    super.radius,
    super.border,
    super.shape = THAvatarShape.circle,
    super.backgroundColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? _defaultSize,
      height: size ?? _defaultSize,
      decoration: BoxDecoration(
        shape: shape == THAvatarShape.circle
            ? BoxShape.circle
            : BoxShape.rectangle,
        borderRadius: shape == THAvatarShape.square
            ? BorderRadius.circular(radius ?? 20)
            : null,
        image: url != null
            ? DecorationImage(
                image: NetworkImage(url ?? ''),
                fit: BoxFit.cover,
              )
            : null,
        color: backgroundColor ?? Colors.grey,
        border: border,
      ),
      child: Center(
        child: Text(
          _str,
          style: TextStyle(
            color: Colors.white,
            fontSize: size ?? _defaultSize / 2,
            height: 1.0,
          ),
        ),
      ),
    );
  }


  String get _str {
    if(text == null) return '';
    return text!.length > 1 ? text!.substring(0, 1) : '';
  }
}
