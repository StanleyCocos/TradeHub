
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trade_hub/src/util/color_ext.dart';
import 'package:trade_hub/trade_hub.dart';

class THQuantityEditor extends StatefulWidget {
  final int count;
  final int min;
  final int max;
  final Color? increaseColor;
  final Color? decreaseColor;
  final Color? increaseTextColor;
  final Color? decreaseTextColor;
  final Color? numberColor;
  final Color? numberTextColor;
  final Function(int)? onChanged;

  const THQuantityEditor({super.key,
    this.count = 1,
    this.min = 1,
    this.max = 99,
    this.increaseColor,
    this.decreaseColor,
    this.increaseTextColor,
    this.decreaseTextColor,
    this.numberColor,
    this.numberTextColor,
    this.onChanged,
  });

  @override
  State<StatefulWidget> createState() => THQuantityEditorState();
}

class THQuantityEditorState extends State<THQuantityEditor> {

  int count = 0;

  @override
  void initState() {
    count = widget.count;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (count - 1 < widget.min){
                //ToastManager.show("至少保留${widget.min}件");
                return;
              }
              count = count - 1;
              setState(() {});
              widget.onChanged?.call(count);
            },
            child: Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: widget.decreaseColor ?? THColor.hex(0xF2F3F5),
                borderRadius: BorderRadius.circular(48.w),
                border: Border.all(
                  color: widget.decreaseTextColor ?? THColor.hex(0xE5E6E8),
                  width: 2.w,
                ),
              ),
              child: Icon(
                Icons.remove,
                size: 40.w,
                color: count == widget.min
                    ? THColor.hex(0xE5E6E8)
                    : THColor.hex(0x1D2129),
              ),
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) {
                  return _QuantityEditorInput(
                    onChanged: (number){
                      count = number;
                      if (number < widget.min){
                        //ToastManager.show("至少保留${ widget.min}件");
                        count = widget.min;
                      }
                      if (number > widget.max){
                        //ToastManager.show("一次最多支援購買${widget.max}件");
                        count = widget.max;
                      }
                      widget.onChanged?.call(number);
                      setState(() {});
                    },
                    number: count,
                  );
                },
              );
            },
            child: Container(
              width: 96.w,
              height: 48.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: widget.numberColor ?? THColor.hex(0xF2F3F5),
                borderRadius: BorderRadius.circular(8.w),
              ),
              child: Text(
                "$count",
                style: TextStyle(
                  color: widget.numberTextColor ?? THColor.black,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () {
              if (count + 1 > widget.max) {
                //ToastManager.show("一次最多支援購買${widget.max}件");
                return;
              }
              count = count + 1;
              setState(() {});
              widget.onChanged?.call(count);
            },
            child: Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: widget.increaseColor ?? THColor.hex(0xF2F3F5),
                borderRadius: BorderRadius.circular(48.w),
                border: Border.all(
                    color:
                        widget.increaseTextColor ?? THColor.hex(0xE5E6E8),
                    width: 2.w),
              ),
              child: Icon(Icons.add,
                  size: 40.w,
                  color: count == widget.max
                      ? THColor.hex(0xE5E6E8)
                      : THColor.hex(0x1D2129)),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuantityEditorInput extends StatefulWidget {

  final int number;
  final Function(int)? onChanged;
  final Function()? onCanceled;

  const _QuantityEditorInput({
    Key? key,
    this.number = 1,
    this.onChanged,
    this.onCanceled,
  });

  @override
  State<StatefulWidget> createState() => _QuantityEditorInputState();
}


class _QuantityEditorInputState extends State<_QuantityEditorInput> {

  String input = "";
  int result = 0;

  @override
  Widget build(BuildContext context) {
    result = widget.number;
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
          maxHeight: MediaQuery.of(context).size.height * 0.75,
        ),
        decoration: BoxDecoration(
          color: THColor.white,
          borderRadius: BorderRadius.circular(16.w),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _title,
            _content,
            const THDivider(),
            _option,
          ],
        ),
      ),
    );
  }

  Widget get _title {
    return Container(
      height: 100.w,
      alignment: Alignment.center,
      child: Text(
        "購買數量",
        style: TextStyle(
          fontSize: 32.sp,
          color: THColor.gray333333,
        ),
      ),
    );
  }

  Widget get _content {

    return Container(
      //padding: EdgeInsets.symmetric(horizontal: 32.w),
      //margin: EdgeInsets.symmetric(vertical: 32.w),
      height: 80,
      width: 130,
      alignment: Alignment.centerLeft,
      color: THColor.white,
      child: Material(
        color: THColor.white,
        child: THInput(
          hint: '請輸入數量',
          height: 58,
          maxLines: 1,
          keyboardType: TextInputType.number,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: THColor.grayEEEEEE,
              width: 1,
            ),
          ),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[-0-9]")),
            LengthLimitingTextInputFormatter(3),
          ],
          autofocus: true,
          showClear: false,
          textAlign: TextAlign.center,
          controller: TextEditingController(text: "${widget.number}"),
          onChanged: (value) {
            input = value;
          },
        ),
      ),
    );
  }

  Widget get _option {
    return Container(
      height: 96.w,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: ()=> {
                Navigator.of(context).pop(),
                widget?.onCanceled?.call()
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "取消",
                  style: TextStyle(
                    fontSize: 28.sp,
                    color: THColor.gray333333,
                  ),
                ),
              ),
            ),
          ),
          VerticalDivider(
            width: 1.w,
            thickness: 1.w,
            color: THColor.grayEEEEEE,
          ),
          Expanded(
            child: GestureDetector(
              onTap: (){
                /*if(input.isEmptyOrNull){
                  ToastManager.show("請輸入購買數量");
                  return;
                }*/
                /*if (!RegexManager.isNumber(input)) {
                  ToastManager.show("請輸入合法購買數量");
                  return;
                }*/
                int num = int.tryParse(input) ?? 0;
                //STRoute.pop();
                Navigator.of(context).pop();
                widget.onChanged?.call(num);
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "確認",
                  style: TextStyle(
                    fontSize: 28.sp,
                    color: THColor.gray333333,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension _SizeExtension on num {
  double get w => this/2;
  double get sp => this/2;
}
