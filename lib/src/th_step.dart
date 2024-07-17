import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class THStep extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Map<String, String> steps;
  final int index;
  final Color? selectedColor;
  final Color? selectedBgColor;

  const THStep({
    Key? key,
    required this.steps,
    this.index = 0,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.selectedColor = const Color(0xFFFF6600),
    this.selectedBgColor = const Color(0xFFFFEFE5),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? ScreenUtil().screenWidth,
      height: height ?? 164.w,
      margin: margin ?? EdgeInsets.symmetric(horizontal: 16.w),
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: (_width / steps.length - 48.w) / 2),
            child: Row(
              children: _children,
            ),
          ),
          SizedBox(height: 16.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: steps.values
                .toList()
                .asMap()
                .map((k, v) {
                  return MapEntry(
                    k,
                    Expanded(
                      child: Text(
                        v,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24.sp,
                          color: k == index
                              ? const Color(0xFF1D2129)
                              : const Color(0xFF4E5969),
                          fontWeight:
                              k == index ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                })
                .values
                .toList(),
          ),
        ],
      ),
    );
  }

  List<Widget> get _children {
    List<Widget> children = [];
    for (int index = 0; index < steps.length; index++) {
      children.add(_item(
        text: steps.values.elementAt(index),
        index: index + 1,
        selected: index == this.index ? true : false,
      ));
      if (index < steps.length - 1) {
        children.add(Expanded(
            child: Container(
          height: 1,
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          width: double.infinity,
          color: index < this.index
              ? selectedColor
              : const Color(0xFFF2F3F5),
        )));
      }
    }
    return children;
  }

  Widget _item({String text = "", int index = 0, bool selected = false}) {
    return Container(
        width: 48.w,
        height: 48.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.w),
            color: index - 1 < this.index
                ? selectedBgColor
                : selected
                    ? selectedColor
                    : const Color(0xFFF2F3F5)),
        alignment: Alignment.center,
        child: index - 1 < this.index
            ? Icon(
                Icons.check,
                color: selectedColor,
                size: 24.w,
              )
            : Text(
                index.toString(),
                style: TextStyle(
                  fontSize: 28.sp,
                  color: selected ? Colors.white : const Color(0xFF4E5969),
                  fontWeight: FontWeight.w600,
                ),
              ));
  }

  double get _width {
    double sWidth = width ?? ScreenUtil().screenWidth;
    EdgeInsets sMargin = margin ?? EdgeInsets.symmetric(horizontal: 16.w);
    EdgeInsets sPadding = padding ?? EdgeInsets.symmetric(horizontal: 16.w);
    return sWidth - sMargin.horizontal - sPadding.horizontal;
  }
}
