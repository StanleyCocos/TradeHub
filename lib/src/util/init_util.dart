
import 'package:tiny_network/tiny_network.dart';

///初始化-网络请求
void initNetwork() {
  return HttpRequest().init(
    HttpRequestSetting(
      connectTimeOut: 15,
      receiveTimeOut: 15,
      contentType: Headers.jsonContentType,
      interceptors: [
      ],
    ),
  );
}

