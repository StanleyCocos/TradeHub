import 'package:flutter/material.dart';
import 'package:trade_hub/src/util/color_ext.dart';

import 'th_date_picker.dart';
import 'th_multi_picker.dart';

class THPicker {

  /// 显示时间选择器
  static void showDatePicker(context,
      {required String title,
      required DatePickerCallback? onConfirm,
      DatePickerCallback? onCancel,
      bool useYear = true,
      bool useMonth = true,
      bool useDay = true,
      bool useHour = false,
      bool useMinute = false,
      bool useSecond = false,
      bool useWeekDay = false,
      Color? barrierColor,
      List<int> dateStart = const [1970, 1, 1],
      List<int>? dateEnd,
      List<int>? initialDate,
      String? rightText,
      String? leftText,
      Duration duration = const Duration(milliseconds: 100),
      double pickerHeight = 200,
      int pickerItemCount = 5}) {
    if (dateEnd == null || initialDate == null) {
      var now = DateTime.now();
      // 如果未指定结束时间，则取当前时间
      dateEnd ??= [now.year, now.month, now.day];
      initialDate ??= [now.year, now.month, now.day];
    }
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        barrierColor: barrierColor ?? THColor.black99000000.withOpacity(0.6),
        builder: (context) {
          return THDatePicker(
              title: title,
              onConfirm: onConfirm,
              onCancel: onCancel,
              rightText: rightText,
              leftText: leftText,
              model: DatePickerModel(
                useYear: useYear,
                useMonth: useMonth,
                useDay: useDay,
                useWeekDay: useWeekDay,
                useHour: useHour,
                useMinute: useMinute,
                useSecond: useSecond,
                dateStart: dateStart,
                dateEnd: dateEnd!,
                dateInitial: initialDate,
              ),
              pickerHeight: pickerHeight,
              pickerItemCount: pickerItemCount);
        });
  }

  /// 显示多级选择器
  static void showMultiPicker(context,
      {String? title,
      required MultiPickerCallback? onConfirm,
      MultiPickerCallback? onCancel,
      required List<List<String>> data,
      List<int>? initialIndexes,
      Duration duration = const Duration(milliseconds: 100),
      Color? barrierColor,
      double pickerHeight = 200,
      int pickerItemCount = 5}) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        barrierColor: barrierColor ?? THColor.black99000000.withOpacity(0.6),
        builder: (context) {
          return THMultiPicker(
            title: title,
            onConfirm: onConfirm,
            onCancel: onCancel,
            data: data,
            initialIndexes: initialIndexes,
            pickerHeight: pickerHeight,
            pickerItemCount: pickerItemCount,
          );
        });
  }

  /// 显示多级联动选择器
  static void showMultiLinkedPicker(context,
      {String? title,
      required MultiPickerCallback? onConfirm,
      MultiPickerCallback? onCancel,
      required Map data,
      required int columnNum,
      required List initialData,
      Duration duration = const Duration(milliseconds: 100),
      Color? barrierColor,
      double pickerHeight = 200,
      int pickerItemCount = 5}) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        barrierColor: barrierColor ?? THColor.black99000000.withOpacity(0.6),
        builder: (context) {
          return THMultiLinkedPicker(
            title: title,
            onConfirm: onConfirm,
            onCancel: onCancel,
            data: data,
            pickerHeight: pickerHeight,
            pickerItemCount: pickerItemCount,
            columnNum: columnNum,
            selectedData: initialData,
          );
        });
  }
}
