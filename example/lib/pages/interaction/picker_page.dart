import 'package:example/pages/example_item.dart';
import 'package:example/pages/example_page.dart';
import 'package:flutter/material.dart';
import 'package:trade_hub/trade_hub.dart';

class PickerPage extends StatefulWidget {
  const PickerPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PickerPageState();
  }
}

class _PickerPageState extends State<PickerPage> {

  String selected_1 = '';
  List<String> data_1 = ['广州市', '韶关市', '深圳市', '珠海区', '汕头市'];

  String selected_2 = '';
  List<List<String>> data_2 = [];

  String selected_3 = '';
  Map data_3 = {
    '广东省': {
      '深圳市': ['南山区南山区南山区南山区南山区', '宝安区', '罗湖区', '福田区'],
      '佛山市': [''],
      '广州市广州市广州市广州市广州市广州市广州市广州市广州市广州市广州市': ['花都区']
    },
    '重庆市': {
      '重庆市重庆市重庆市重庆市重庆市重庆市重庆市': ['九龙坡区', '江北区']
    },
    '浙江省浙江省浙江省浙江省浙江省浙江省浙江省浙江省': {
      '杭州市': ['西湖区', '余杭区', '萧山区'],
      '宁波市': ['江东区', '北仑区', '奉化市']
    },
    '香港': {
      '香港': ['九龙城区', '黄大仙区', '离岛区', '湾仔区']
    }
  };

  @override
  void initState() {
    var list = <String>[];
    for(var i = 2022; i >= 2000; i--) {
      list.add('${i}年');
    }
    data_2.add(list);
    data_2.add(['春', '夏', '秋', '冬']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExamplePage(
      title: '选择器',
      children: [
        ExampleItem(
          title: "地区",
          widget: buildArea(context),
        ),
        ExampleItem(
          title: "时间",
          widget: buildTime(context),
        ),
        ExampleItem(
          title: "地区--联动",
          widget: buildMultiArea(context),
        ),
      ],
    );
  }

  Widget buildArea(BuildContext context) {
    return GestureDetector(
      onTap: (){
        THPicker.showMultiPicker(context, title: '选择地区',
            onConfirm: (selected) {
              setState(() {
                selected_1 = data_1[selected[0]];
              });
              Navigator.of(context).pop();
            }, data: [data_1]);
      },
      child: buildSelectRow(context, selected_1, '选择地区'),
    );
  }

  Widget buildTime(BuildContext context) {
    return GestureDetector(
      onTap: (){
        THPicker.showMultiPicker(context, title: '选择时间',
            onConfirm: (selected) {
              setState(() {
                selected_2 = '${data_2[0][selected[0]]} ${data_2[1][selected[1]]}';
              });
              Navigator.of(context).pop();
            }, data: data_2);
      },
      child: buildSelectRow(context, selected_2, '选择时间'),
    );
  }

  Widget buildMultiArea(BuildContext context) {
    return GestureDetector(
      onTap: (){
        THPicker.showMultiLinkedPicker(context, title: '选择地区',
            onConfirm: (selected) {
              setState(() {
                selected_3 = '${selected[0]} ${selected[1]} ${selected[2]}';
              });
              Navigator.of(context).pop();
            },
            data: data_3,
            columnNum: 3,
            initialData: ['浙江省', '杭州市', '西湖区']);
      },
      child: buildSelectRow(context, selected_3, '选择地区'),
    );
  }

  Widget buildSelectRow(BuildContext context, String output, String title) {
    return Container(
      color: const Color(0xFFFFFFFF),
      height: 56,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                child: THText(title, font: Font(size:16,lineHeight: 24),),
              ),
              Expanded(child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: Row(
                  children: [
                    Expanded(child: THText(
                      output,
                      font: Font(size:16,lineHeight: 24),
                      textColor: const Color(0x66000000).withOpacity(0.4),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )),
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Icon(
                        Icons.chevron_right,
                        color: const Color(0x66000000).withOpacity(0.4),),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ],
      ),
    );
  }
}
