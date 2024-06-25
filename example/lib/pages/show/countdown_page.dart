import 'package:flutter/material.dart';
import 'package:trade_hub/trade_hub.dart';

class CountdownPage extends StatefulWidget {
  const CountdownPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CountdownState();
}

class _CountdownState extends State<CountdownPage> {
  final THCountdownController _controller = THCountdownController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('倒计时'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 32),
            countdown1(),
            const SizedBox(height: 32),
            countdown2(),
            const SizedBox(height: 32),
            countdown3(),
          ],
        ),
      ),
    );
  }

  Widget countdown1() {
    int duration = 10;
    return Row(
      children: [
        const SizedBox(
          width: 80,
          child: Text(
            "验证码例子: ",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(width: 32),
        GestureDetector(
          onTap: () => _controller.start(),
          child: THCountdown(
            duration: duration,
            controller: _controller,
            builder: (_, int tick, active) {
              return Container(
                width: 200,
                height: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: active ? Colors.grey : const Color(0xFFFF6600),
                  borderRadius: BorderRadius.circular(45),
                ),
                child: Text(
                  "发送验证码${active ? '($tick)' : ''}",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget countdown2() {
    return Row(
      children: [
        const SizedBox(
          width: 80,
          child: Text(
            "自动倒计时: ",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(width: 32),
        THCountdown(
          duration: 5,
          builder: (_, tick, active) {
            return Container(
              width: 60,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: tick > 0
                    ? Colors.black87.withOpacity(0.5)
                    : const Color(0xFFFF6600),
                borderRadius: BorderRadius.circular(45),
              ),
              child: Text(
                tick > 0 ? "${'$tick'}S" : "跳过",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget countdown3() {
    return Row(
      children: [
        const SizedBox(
          width: 80,
          child: Text(
            "文本倒计时: ",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(width: 32),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: '这是第一段文本, ',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red,
                  ),
                ),
                WidgetSpan(
                  child: THCountdown(
                    duration: 1126993,
                    builder: (_, tick, active) {
                      Duration ss = Duration(seconds: tick);

                      return Text(
                        '优惠活动剩余: ${formatDuration(ss)}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.lightBlue,
                        ),
                      );
                    },
                  ),
                ),
                const TextSpan(
                  text: '这是第二段文本 它很可能会长很长，甚至换行',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }


  String formatDuration(Duration duration) {
    int days = duration.inDays;
    int hours = duration.inHours % 24;
    int minutes = duration.inMinutes % 60;
    int seconds = duration.inSeconds % 60;
    return '${days.toString().padLeft(2, '0')}天 ${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
