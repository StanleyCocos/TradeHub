import 'package:flutter/material.dart';
import 'package:trade_hub/trade_hub.dart';

class PopupPage extends StatefulWidget {
  const PopupPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PopupState();
}

class _PopupState extends State<PopupPage> {
  GlobalKey key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('popup'),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _lt,
            const SizedBox(height: 20),
            _lb,
            const SizedBox(height: 20),
            _rt,
            const SizedBox(height: 20),
            _rb,
          ],
        ),
      ),
    );
  }

  Widget get _lt {
    return THPopup(
      offset: const Offset(0, 0),
      origin: THPopupOrigin.lt,
      builder: (BuildContext context) {
        return THPopupItem(
          child: Container(
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black87.withOpacity(0.6),
            ),
            child: Column(
              children: [
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: const Text(
                    "选项一",
                    style: TextStyle(
                      fontSize: 16,
                      decoration: TextDecoration.none,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: const Text(
                    "弹出",
                    style: TextStyle(
                      fontSize: 16,
                      decoration: TextDecoration.none,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        width: 160,
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          "以左上为起点",
          style: TextStyle(
            fontSize: 16,
            decoration: TextDecoration.none,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget get _lb {
    return THPopup(
      offset: const Offset(0, 0),
      origin: THPopupOrigin.lb,
      builder: (BuildContext context) {
        return THPopupItem(
          child: Container(
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black87.withOpacity(0.6),
            ),
            child: Column(
              children: [
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: const Text(
                    "选项一",
                    style: TextStyle(
                      fontSize: 16,
                      decoration: TextDecoration.none,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: const Text(
                    "弹出",
                    style: TextStyle(
                      fontSize: 16,
                      decoration: TextDecoration.none,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        width: 160,
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          "以左下为起点",
          style: TextStyle(
            fontSize: 16,
            decoration: TextDecoration.none,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget get _rt {
    return THPopup(
      offset: const Offset(0, 0),
      origin: THPopupOrigin.rt,
      builder: (BuildContext context) {
        return THPopupItem(
          child: Container(
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black87.withOpacity(0.6),
            ),
            child: Column(
              children: [
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: const Text(
                    "选项一",
                    style: TextStyle(
                      fontSize: 16,
                      decoration: TextDecoration.none,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: const Text(
                    "弹出",
                    style: TextStyle(
                      fontSize: 16,
                      decoration: TextDecoration.none,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        width: 160,
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          "以左下为起点",
          style: TextStyle(
            fontSize: 16,
            decoration: TextDecoration.none,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget get _rb {
    return THPopup(
      offset: const Offset(0, 0),
      origin: THPopupOrigin.rb,
      builder: (BuildContext context) {
        return THPopupItem(
          child: Container(
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black87.withOpacity(0.6),
            ),
            child: Column(
              children: [
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: const Text(
                    "选项一",
                    style: TextStyle(
                      fontSize: 16,
                      decoration: TextDecoration.none,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: const Text(
                    "弹出",
                    style: TextStyle(
                      fontSize: 16,
                      decoration: TextDecoration.none,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        width: 160,
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          "以左下为起点",
          style: TextStyle(
            fontSize: 16,
            decoration: TextDecoration.none,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
