import 'package:flutter/material.dart';

enum THCheckBoxType {
  /// 单选框
  radio,

  /// 复选框
  checkbox,
}

enum THCheckBoxDirection {
  /// 横向
  horizontal,

  /// 纵向
  vertical,
}

/// 选项框控制器
class THCheckBoxController {

  _THCheckBoxState? _state;

  /// 操作全部
  /// @param checked 是否选中
  void toggleAll(bool checked) {
    bool isRadio = _state?.widget.type == THCheckBoxType.radio;
    if(isRadio) {
      return;
    }
    _state?.toggleAll(checked);
  }

  /// 反选全部
  void reverseAll() {
    bool isRadio = _state?.widget.type == THCheckBoxType.radio;
    if(isRadio) {
      return;
    }
    _state?.reverseAll();
  }

  /// 选中某项
  void toggle(int index, bool check) {
    _state?.toggle(index, check);
  }

  /// 获取选中的列表
  List allChecked() {
    //return _state?.checkBoxStates.where((k, v) => v).keys.toList() ?? [];
    return _state?.getAllChecked() ?? [];
  }

  /// 获取某项的选中状态
  bool checked(int index) {
    var item = _state?.widget.itemList[index];
    var list = allChecked();
    return list.contains(item);
  }

}

/// 单选框/复选框
class THCheckBox<T> extends StatefulWidget {

  final THCheckBoxController? controller;

  /// 构建 item widget
  /// @param context 上下文
  /// @param index 索引
  /// @param item 数据
  /// @param isCheck 是否选中
  Widget? Function(BuildContext context, int index, T item, bool isCheck)
      itemBuilder;

  /// 点击选中状态改变回调
  /// @param checkedList 选中的列表,包含最新的选中状态
  /// @param index 当前选中的索引
  /// @param isCheck 当前选中状态
  final Function(List<T> checkedList, int index, bool isCheck)? onClickCheckChanged;

  /// 选中状态改变回调
  final Function(List<T> checkedList)? onCheckChanged;

  /// 选中的列表
  List<T>? checkedList;

  /// 数据列表
  List<T> itemList = [];

  /// 方向 默认纵向
  THCheckBoxDirection direction = THCheckBoxDirection.vertical;

  /// 类型 默认复选框
  THCheckBoxType type = THCheckBoxType.checkbox;

  /// 横向间距
  double spacing = 0.0;

  /// 纵向间距
  double runSpacing = 0.0;

  THCheckBox({
    super.key,
    required this.itemList,
    required this.itemBuilder,
    this.controller,
    this.direction = THCheckBoxDirection.vertical,
    this.type = THCheckBoxType.checkbox,
    this.checkedList,
    this.spacing = 0.0,
    this.runSpacing = 0.0,
    this.onClickCheckChanged,
    this.onCheckChanged,
  });

  @override
  State<StatefulWidget> createState() {
    return _THCheckBoxState<T>();
  }
}

class _THCheckBoxState<T> extends State<THCheckBox<T>> {
  @override
  void initState() {
    widget.checkedList ??= <T>[];
    super.initState();
    widget.controller?._state = this;
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.direction) {
      case THCheckBoxDirection.horizontal:
        return _buildHorizontal(context);
      case THCheckBoxDirection.vertical:
        return _buildVertical(context);
    }
  }

  Widget _buildHorizontal(BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < widget.itemList.length; i++) {
      Widget itemView = _buildItem(context, i);
      children.add(itemView);
    }
    return SingleChildScrollView(
      child: Wrap(
        spacing: widget.spacing, // 主轴方向的间距
        runSpacing: widget.runSpacing, // 纵轴方向的间距
        children: children,
      ),
    );
  }

  Widget _buildVertical(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: widget.itemList.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return _buildItem(context, index);
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: widget.runSpacing);
      },
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    T item = widget.itemList[index];
    bool isChecked = widget.checkedList?.contains(item) ?? false;
    Widget? itemView =
        widget.itemBuilder?.call(context, index, item, isChecked);
    return GestureDetector(
      onTap: () {
        _onClickItem(index, item, isChecked);
      },
      child: itemView,
    );
  }

  void _onClickItem(int index, T item, bool isChecked) {
    List<T> checkedList = widget.checkedList ?? [];
    switch (widget.type) {
      case THCheckBoxType.radio:
        checkedList.clear();
        checkedList.add(item);
        break;
      case THCheckBoxType.checkbox:
        if (checkedList.contains(item)) {
          checkedList.remove(item);
        } else {
          checkedList.add(item);
        }
        break;
    }
    widget.onClickCheckChanged?.call(checkedList, index, !isChecked);
    setState(() {});
  }

  ///-------- 控制器方法实现 ------------
  /// 全选/全不选
  void toggleAll(bool check) {
    if(widget.checkedList == null) {
      return;
    }
    if(check) {
      widget.checkedList!.clear();
      widget.checkedList!.addAll(widget.itemList);
    }else {
      widget.checkedList!.clear();
    }
    widget.onCheckChanged?.call(widget.checkedList!);
    setState(() {});
  }

  /// 选中某项
  bool toggle(int index, bool check, {notify = true}) {
    if(index < 0 || index >= widget.itemList.length || widget.checkedList == null) {
      return false;
    }
    //bool checked = true;
    if(check){
      var item = widget.itemList[index];
      if(!widget.checkedList!.contains(item)) {
        widget.checkedList?.add(item);
      }
    }else {
      widget.checkedList!.removeAt(index);
    }
    widget.onCheckChanged?.call(widget.checkedList!);
    if(notify){
      setState(() {});
    }
    return true;
  }

  /// 反选
  void reverseAll() {
    if(widget.checkedList == null) {
      return;
    }
    List<T> list = [];
    for(int i = 0; i < widget.itemList.length; i++) {
      var item = widget.itemList[i];
      if(!widget.checkedList!.contains(item)) {
        list.add(item);
      }
    }
    widget.checkedList!.clear();
    widget.checkedList!.addAll(list);
    widget.onCheckChanged?.call(widget.checkedList!);
    setState(() {});
  }

  /// 获取选中的列表
  List<T> getAllChecked() {
    return widget.checkedList ?? [];
  }

}


extension THCheckBoxControllerFun<T> on _THCheckBoxState<T> {

}

class THCheckboxItem extends StatelessWidget {
  final String title;
  final bool checked;

  const THCheckboxItem({
    super.key,
    required this.title,
    required this.checked,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Row(
        children: [
          Icon(
            checked ? Icons.check_circle : Icons.radio_button_unchecked,
            color: checked ? Colors.red : Colors.grey,
          ),
          Text(title),
        ],
      ),
    );
  }
}
