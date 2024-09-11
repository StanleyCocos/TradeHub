import 'package:example/pages/example_item.dart';
import 'package:example/pages/example_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:trade_hub/trade_hub.dart';

class SwiperPage extends StatelessWidget {
  const SwiperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExamplePage(
      title: "Swiper 轮播图",
      children: [
        ExampleItem(title: "点状指示器", widget: _wrap(_buildDotsSwiper())),
        ExampleItem(title: "点条状", widget: _wrap(_buildDotsBarSwiper())),
        ExampleItem(title: "分式", widget: _wrap(_buildFractionSwiper())),
        ExampleItem(title: "切换按钮", widget: _wrap(_buildControlsSwiper())),
        ExampleItem(title: "卡片式", widget: _wrap(_buildCardsSwiper())),
        ExampleItem(title: "卡片式-scale:0.8", widget: _wrap(_buildScaleCardsSwiper())),
        ExampleItem(title: "外部", widget: _wrap(_buildOuterDotsSwiper())),
        ExampleItem(title: "右边(竖向)", widget: _wrap(_buildRightDotsSwiper())),
      ],
    );
  }

  Widget _buildRightDotsSwiper() {
    return Swiper(
      viewportFraction: 0.75,
      autoplay: true,
      itemCount: 6,
      loop: true,
      scrollDirection: Axis.vertical,
      transformer: THPageTransformer.scaleAndFade(),
      pagination: const SwiperPagination(
        alignment: Alignment.centerRight,
        builder: THSwiperPagination.dots, //分式
      ),
      itemBuilder: (BuildContext context, int index) {
        return const THImage(
          assetUrl: 'assets/images/image.jpg',
        );
      },
    );
  }

  Widget _buildOuterDotsSwiper() {
    return Swiper(
      viewportFraction: 0.75,
      autoplay: true,
      itemCount: 6,
      loop: true,
      outer: true,
      transformer: THPageTransformer.scaleAndFade(),
      pagination: const SwiperPagination(
        alignment: Alignment.center,
        builder: THSwiperPagination.dots, //分式
      ),
      itemBuilder: (BuildContext context, int index) {
        return const THImage(
          assetUrl: 'assets/images/image.jpg',
        );
      },
    );
  }

  Widget _buildScaleCardsSwiper() {
    return Swiper(
      viewportFraction: 0.75,
      autoplay: true,
      itemCount: 6,
      loop: true,
      transformer: THPageTransformer.scaleAndFade(),
      pagination: const SwiperPagination(
        alignment: Alignment.center,
        builder: THSwiperPagination.controls, //分式
      ),
      itemBuilder: (BuildContext context, int index) {
        return const THImage(
          assetUrl: 'assets/images/image.jpg',
        );
      },
    );
  }

  Widget _buildCardsSwiper() {
    return Swiper(
      viewportFraction: 0.75,
      autoplay: true,
      itemCount: 6,
      loop: true,
      transformer: THPageTransformer.margin(),
      pagination: const SwiperPagination(
        alignment: Alignment.center,
        builder: THSwiperPagination.controls, //分式
      ),
      itemBuilder: (BuildContext context, int index) {
        return const THImage(
          assetUrl: 'assets/images/image.jpg',
        );
      },
    );
  }

  Widget _buildControlsSwiper() {
    return Swiper(
      autoplay: true,
      itemCount: 6,
      loop: true,
      pagination: const SwiperPagination(
        alignment: Alignment.center,
        builder: THSwiperPagination.controls, //分式
      ),
      itemBuilder: (BuildContext context, int index) {
        return const THImage(
          assetUrl: 'assets/images/image.jpg',
        );
      },
    );
  }

  Widget _buildFractionSwiper() {
    return Swiper(
      autoplay: true,
      itemCount: 6,
      loop: true,
      pagination: const SwiperPagination(
        alignment: Alignment.bottomCenter,
        builder: THSwiperPagination.fraction, //分式
      ),
      itemBuilder: (BuildContext context, int index) {
        return const THImage(
          assetUrl: 'assets/images/image.jpg',
        );
      },
    );
  }

  Widget _buildDotsBarSwiper() {
    return Swiper(
      autoplay: true,
      itemCount: 6,
      loop: true,
      pagination: const SwiperPagination(
        alignment: Alignment.bottomCenter,
        builder: THSwiperPagination.dotsBar, //点条状
      ),
      itemBuilder: (BuildContext context, int index) {
        return const THImage(
          assetUrl: 'assets/images/image.jpg',
        );
      },
    );
  }

  Widget _buildDotsSwiper() {
    return Swiper(
      autoplay: true,
      itemCount: 6,
      loop: true,
      pagination: const SwiperPagination(
        alignment: Alignment.bottomCenter,
        builder: THSwiperPagination.dots,   //点状
      ),
      itemBuilder: (BuildContext context, int index) {
        return const THImage(
          assetUrl: 'assets/images/image.jpg',
        );
      },
    );
  }

  Widget _wrap(Widget child) {
    return Container(
      height: 193,
      margin: const EdgeInsets.only(left: 16, right: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: child,
      ),
    );
  }
}
