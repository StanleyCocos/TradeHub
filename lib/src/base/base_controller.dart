import 'package:flutter/cupertino.dart';

import '../th_toast.dart';
import 'base.dart';
import 'base_model.dart';

abstract class BaseController<T extends BaseModel> extends ChangeNotifier
    implements
        BaseControllerLifeCycle,
        BaseOverrideController<T>,
        BaseControllerCommonMethod {
  /// 当前页面上下文
  late BuildContext context;

  /// 是否加载中
  @override
  bool get loading => isLoadFirst;

  /// 是否页面错误
  @override
  bool get error => isLoadError;

  /// 是否空页面
  @override
  bool get empty => false;

  /// 是否正常显示内容
  @override
  bool get content => false;

  /// 是否需要控制点击屏幕任意位置 隐藏键盘
  bool get isHideKeyboard => true;

  /// 是否第一次加载
  bool isLoadFirst = true;

  /// 是否加载错误
  bool isLoadError = false;

  /// 视图渲染完成(只调用一次)
  @override
  void widgetDidLoad() {}

  /// 视图销毁
  @override
  void widgetDispose() {}

  /// 页面开始加载(只调用一次)
  @override
  void initLoad() {
    initRouteArguments();
  }

  /// 初始化路由参数
  @override
  void initRouteArguments() {}

  /// 隐藏键盘
  @override
  void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  /// 屏幕点击
  @override
  void onScreenClick() {
    if (isHideKeyboard) hideKeyboard();
  }

  /// 点击重新请求
  void loadRetry() {}
}

extension Common on BaseController {
  /// 获取页面状态
  PageStateType get switchState {
    if (content) {
      if (isLoadFirst) isLoadFirst = false;
      return PageStateType.content;
    }
    if (loading) {
      isLoadFirst = false;
      return PageStateType.loading;
    }
    if (error) return PageStateType.error;
    if (empty) return PageStateType.empty;
    return PageStateType.content;
  }

}

extension Load on BaseController {

  ///显示提示
  void toast(String message) {
    THToast.showText(message, context: context);
  }
}
