
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:trade_hub/src/util/color_ext.dart';

class THScaleImagePage extends StatefulWidget {
  final List<String> imageList;
  final int startIndex;

  const THScaleImagePage({super.key, required this.imageList, required this.startIndex});

  @override
  State<StatefulWidget> createState() {
    return _THScaleImagePageState();
  }
}

class _THScaleImagePageState extends State<THScaleImagePage> {

  late PageController controller;
  int startIndex = 0;

  @override
  void initState() {
    controller = PageController(initialPage: widget.startIndex);
    startIndex = widget.startIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: false,
      resizeToAvoidBottomInset: true,
      body: _content,
    );
  }

  Widget get _content {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: Navigator.of(context).pop,
          child: galleryView(),
        ),
        Positioned(
          bottom: 0,
          child: tipWidget(),
        ),
      ],
    );
  }

  ///可放大画廊
  Widget galleryView() {
    return PhotoViewGallery.builder(
      itemCount: widget.imageList.length,
      builder: (context, index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: NetworkImage(widget.imageList[index]),
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 2,
        );
      },
      loadingBuilder: (context, index) {
        return Container(
          color: THColor.black,
          alignment: Alignment.center,
          child: Text(
            "加載中...",
            style: TextStyle(
              color: THColor.white,
              fontSize: 14,
            ),
          ),
        );
      },
      pageController: controller,
      onPageChanged: (int index) {
        startIndex = index;
        setState(() {});
      },
      backgroundDecoration: const BoxDecoration(color: Colors.black),
    );
  }

  ///提示视图
  Widget tipWidget() {
    List<Widget> children = [];
    widget.imageList.forEach((it) {
      int index = widget.imageList.indexOf(it);
      if (index > 0) {
        children.add(const SizedBox(width: 10));
      }
      children.add(Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
          color: index == widget.startIndex
              ? Colors.white
              : Colors.white30,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
      ));
    });

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      child: Row(children: children),
    );
  }
}

