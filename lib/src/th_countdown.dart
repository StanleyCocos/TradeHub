import 'dart:async';

import 'package:flutter/cupertino.dart';

typedef THCountdownBuilder = Widget Function(BuildContext context, int tick, bool active);

class THCountdownController {
  Timer? _timer;
  int _duration = 60;
  int _interval = 1;
  final StreamController<int> streamController = StreamController();

  THCountdownController();

  void setDuration(int duration, int interval) {
    _interval = interval;
    _duration = duration;
  }

  /// 开始倒计时
  void start() {
    if (_timer != null && _timer!.isActive) return;
    stop();
    _timer = Timer.periodic(Duration(seconds: _interval), (timer) {
      streamController.add(timer.tick * _interval);
      if (timer.tick * _interval > _duration) stop();
    });
  }

  /// 结束倒计时
  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  void dispose() {
    stop();
    streamController.close();
  }
}

class THCountdown extends StatefulWidget {
  /// 倒计时总时长 单位秒
  final int duration;

  /// 倒计时间隔 单位秒
  final int interval;

  /// 倒计时构建器
  final THCountdownBuilder builder;

  /// 倒计时控制器
  final THCountdownController? controller;

  /// 倒计时结束回调
  final Function(int)? onDone;

  const THCountdown({
    Key? key,
    required this.duration,
    required this.builder,
    this.controller,
    this.interval = 1,
    this.onDone,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _THDesignState();
}

class _THDesignState extends State<THCountdown> {
  late THCountdownController _controller;

  @override
  void initState() {
    if (widget.controller == null) {
      _controller = THCountdownController();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.start();
      });
    } else {
      _controller = widget.controller!;
    }
    _controller.setDuration(widget.duration, widget.interval);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _controller.streamController.stream,
      builder: (context, snapshot) {
        var value = snapshot.data ?? 0;
        var view = widget.builder.call(
          context,
          widget.duration - value,
          value > 0 && value < widget.duration,
        );
        if (value >= widget.duration) widget.onDone?.call(value);
        return view;
      },
    );
  }
}
