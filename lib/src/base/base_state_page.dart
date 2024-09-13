import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'base.dart';
import 'base_controller.dart';


abstract class BasePageState<T extends StatefulWidget, C extends BaseController>
    extends State<T> implements PageInterface, BaseOverrideStatePage<C> {
  @override
  void initState() {
    controller.initLoad();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => controller.widgetDidLoad());
    super.initState();
  }

  @override
  void dispose() {
    controller.widgetDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return renderLayout;
  }

  /// 渲染视图
  Widget get renderLayout {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: style,
      child: ChangeNotifierProvider.value(
        value: controller,
        child: Consumer<C>(
          builder: (context, controller, _) {
            return GestureDetector(
              onTap: controller.onScreenClick,
              child: Scaffold(
                backgroundColor: backgroundColor,
                extendBodyBehindAppBar: extendBodyBehindAppBar,
                resizeToAvoidBottomInset: resizeToAvoidBottomInset,
                appBar: navigation as PreferredSizeWidget?,
                bottomNavigationBar: bottomNavigation,
                body: body,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget get body => statePage;

  Widget get statePage {
    final state = controller.switchState;
    switch (state) {
      case PageStateType.content:
        return content;
      default:
        return content;
    }
  }

  Color get backgroundColor => Colors.white;

  bool get extendBodyBehindAppBar => false;

  /// 防止键盘重绘顶起背景
  bool get resizeToAvoidBottomInset => true;

  /// 状态栏颜色
  SystemUiOverlayStyle get style => SystemUiOverlayStyle.dark;

  @override
  Widget? get bottomNavigation => null;

  @override
  Widget? get navigation => null;
}
