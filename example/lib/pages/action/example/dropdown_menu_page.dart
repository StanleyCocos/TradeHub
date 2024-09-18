

import 'package:example/pages/example_item.dart';
import 'package:example/pages/example_page.dart';
import 'package:flutter/material.dart';
import 'package:trade_hub/trade_hub.dart';

class DropdownMenuPage extends StatefulWidget {

  const DropdownMenuPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DropdownMenuPageState();
  }
}

class DropdownMenuPageState extends State<DropdownMenuPage> {

  @override
  Widget build(BuildContext context) {
    return ExamplePage(
      children: [
        ExampleItem(title: '下拉菜单', widget: _buildDownSimple),
        ExampleItem(title: '下拉菜单-多选', widget: _buildDownMultiple),
        ExampleItem(title: '下拉菜单-禁用项', widget: _buildDownDisabled),
        ExampleItem(title: '下拉菜单-最大高度限制', widget: _buildDownMaxHeight),
        ExampleItem(title: '下拉菜单-自动方向', widget: _buildAutoDirection),
        ExampleItem(title: '下拉菜单-自定义布局', widget: _buildCustomLayout),

      ],
    );
  }

  Widget get _buildCustomLayout {
    return Container(
      color: Colors.white,
      child: THDropdownMenu(
        direction: THDropdownMenuDirection.auto,
        activateColor: Colors.red,
        onMenuOpened: (value) {
          print('打开第$value个菜单');
        },
        onMenuClosed: (value) {
          print('关闭第$value个菜单');
        },
        items: [
          THDropdownItem(
            selectedColor: Colors.red,
            //maxHeight: 150,
            multiple: true,
            label: "自定义",
            builder: (BuildContext context, THDropdownItemState itemState, THDropdownPopup? popupState) {
              return Container(
                color: Colors.white,
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        THText(
                          '自定义布局',
                        ),
                      ],
                    ),
                    const THDivider(),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              itemState.close();
                            },
                            child: Container(
                              height: 40,
                              alignment: Alignment.center,
                              child: THText('自定义项$index'),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
            onChange: (value) {
              print('选择：$value');
            },
          ),
          THDropdownItem(
            options: [
              THDropdownItemOption(label: '默认排序', value: 'default', selected: true),
              THDropdownItemOption(label: '价格从高到低', value: 'price'),
            ],
          ),

          THDropdownItem(
            options: [
              THDropdownItemOption(label: '高級篩選', value: 'default', selected: true),
              THDropdownItemOption(label: '价格从高到低1', value: 'price'),
              THDropdownItemOption(label: '价格从高到低2', value: 'price'),
            ],
          ),
        ],
      ),
    );
  }

  Widget get _buildAutoDirection {
    return Container(
      color: Colors.white,
      child: THDropdownMenu(
        direction: THDropdownMenuDirection.auto,
        activateColor: Colors.red,
        onMenuOpened: (value) {
          print('打开第$value个菜单');
        },
        onMenuClosed: (value) {
          print('关闭第$value个菜单');
        },
        items: [
          THDropdownItem(
            selectedColor: Colors.red,
            //maxHeight: 150,
            multiple: true,
            label: "多选",
            options: [
              THDropdownItemOption(label: '全部产品', value: 'all', selected: true),
              THDropdownItemOption(label: '最新产品', value: 'new'),
              THDropdownItemOption(label: '最火产品', value: 'hot'),
              THDropdownItemOption(label: '最火产品2', value: 'hot'),
              THDropdownItemOption(label: '最火产品3', value: 'hot'),
            ],
            onChange: (value) {
              print('选择：$value');
            },
          ),
          THDropdownItem(
            options: [
              THDropdownItemOption(label: '默认排序', value: 'default', selected: true),
              THDropdownItemOption(label: '价格从高到低', value: 'price'),
            ],
          ),

          THDropdownItem(
            options: [
              THDropdownItemOption(label: '高級篩選', value: 'default', selected: true),
              THDropdownItemOption(label: '价格从高到低1', value: 'price'),
              THDropdownItemOption(label: '价格从高到低2', value: 'price'),
            ],
          ),
        ],
      ),
    );
  }


   Widget get _buildDownMultiple {
    return Container(
      color: Colors.white,
      child: THDropdownMenu(
        direction: THDropdownMenuDirection.down,
        activateColor: Colors.red,
        onMenuOpened: (value) {
          print('打开第$value个菜单');
        },
        onMenuClosed: (value) {
          print('关闭第$value个菜单');
        },
        items: [
          THDropdownItem(
            selectedColor: Colors.red,
            //maxHeight: 150,
            multiple: true,
            label: "多选",
            options: [
              THDropdownItemOption(label: '全部产品', value: 'all', selected: true),
              THDropdownItemOption(label: '最新产品', value: 'new'),
              THDropdownItemOption(label: '最火产品', value: 'hot'),
              THDropdownItemOption(label: '最火产品2', value: 'hot'),
              THDropdownItemOption(label: '最火产品3', value: 'hot'),
            ],
            onChange: (value) {
              print('选择：$value');
            },
          ),
          THDropdownItem(
            options: [
              THDropdownItemOption(label: '默认排序', value: 'default', selected: true),
              THDropdownItemOption(label: '价格从高到低', value: 'price'),
            ],
          ),

          THDropdownItem(
            options: [
              THDropdownItemOption(label: '高級篩選', value: 'default', selected: true),
              THDropdownItemOption(label: '价格从高到低1', value: 'price'),
              THDropdownItemOption(label: '价格从高到低2', value: 'price'),
            ],
          ),
        ],
      ),
    );
  }



  Widget get _buildDownMaxHeight {
    return Container(
      color: Colors.white,
      child: THDropdownMenu(
        direction: THDropdownMenuDirection.down,
        activateColor: Colors.red,
        onMenuOpened: (value) {
          print('打开第$value个菜单');
        },
        onMenuClosed: (value) {
          print('关闭第$value个菜单');
        },
        items: [
          THDropdownItem(
            selectedColor: Colors.red,
            maxHeight: 150,
            options: [
              THDropdownItemOption(label: '全部产品', value: 'all', selected: true),
              THDropdownItemOption(label: '最新产品', value: 'new'),
              THDropdownItemOption(label: '最火产品', value: 'hot'),
              THDropdownItemOption(label: '最火产品2', value: 'hot'),
              THDropdownItemOption(label: '最火产品3', value: 'hot'),
            ],
            onChange: (value) {
              print('选择：$value');
            },
          ),
          THDropdownItem(
            options: [
              THDropdownItemOption(label: '默认排序', value: 'default', selected: true),
              THDropdownItemOption(label: '价格从高到低', value: 'price'),
            ],
          ),

          THDropdownItem(
            options: [
              THDropdownItemOption(label: '高級篩選', value: 'default', selected: true),
              THDropdownItemOption(label: '价格从高到低1', value: 'price'),
              THDropdownItemOption(label: '价格从高到低2', value: 'price'),
            ],
          ),
        ],
      ),
    );
  }



  Widget get _buildDownDisabled {
    return Container(
      color: Colors.white,
      child: THDropdownMenu(
        direction: THDropdownMenuDirection.down,
        activateColor: Colors.red,
        onMenuOpened: (value) {
          print('打开第$value个菜单');
        },
        onMenuClosed: (value) {
          print('关闭第$value个菜单');
        },
        items: [
          THDropdownItem(
            selectedColor: Colors.red,
            disabled: true,
            options: [
              THDropdownItemOption(label: '全部产品', value: 'all', selected: true),
              THDropdownItemOption(label: '最新产品', value: 'new'),
              THDropdownItemOption(label: '最火产品', value: 'hot'),
              THDropdownItemOption(label: '最火产品2', value: 'hot'),
              THDropdownItemOption(label: '最火产品3', value: 'hot'),
            ],
            onChange: (value) {
              print('选择：$value');
            },
          ),
          THDropdownItem(
            options: [
              THDropdownItemOption(label: '默认排序', value: 'default', selected: true),
              THDropdownItemOption(label: '价格从高到低', value: 'price'),
            ],
          ),

          THDropdownItem(
            options: [
              THDropdownItemOption(label: '高級篩選', value: 'default', selected: true),
              THDropdownItemOption(label: '价格从高到低1', value: 'price'),
              THDropdownItemOption(label: '价格从高到低2', value: 'price'),
            ],
          ),
        ],
      ),
    );
  }


  Widget get _buildDownSimple {
    return Container(
      color: Colors.white,
      child: THDropdownMenu(
        direction: THDropdownMenuDirection.down,
        activateColor: Colors.red,
        onMenuOpened: (value) {
          print('打开第$value个菜单');
        },
        onMenuClosed: (value) {
          print('关闭第$value个菜单');
        },
        items: [
          THDropdownItem(
            selectedColor: Colors.red,
            options: [
              THDropdownItemOption(label: '全部产品', value: 'all', selected: true),
              THDropdownItemOption(label: '最新产品', value: 'new'),
              THDropdownItemOption(label: '最火产品', value: 'hot'),
              THDropdownItemOption(label: '最火产品2', value: 'hot'),
              THDropdownItemOption(label: '最火产品3', value: 'hot'),
            ],
            onChange: (value) {
              print('选择：$value');
            },
          ),
          THDropdownItem(
            options: [
              THDropdownItemOption(label: '默认排序', value: 'default', selected: true),
              THDropdownItemOption(label: '价格从高到低', value: 'price'),
            ],
          ),

          THDropdownItem(
            options: [
              THDropdownItemOption(label: '高級篩選', value: 'default', selected: true),
              THDropdownItemOption(label: '价格从高到低1', value: 'price'),
              THDropdownItemOption(label: '价格从高到低2', value: 'price'),
            ],
          ),
        ],
      ),
    );
  }

}