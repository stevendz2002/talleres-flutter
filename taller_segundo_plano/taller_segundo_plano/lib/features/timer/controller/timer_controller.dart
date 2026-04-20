import 'dart:async';
import 'package:taller_segundo_plano/core/utils/app_logger.dart';

class TimerController {
  Timer? _timer;
  int hundredths = 0;
  bool running = false;
  bool paused = false;

  String get formattedTime {
    final totalSeconds = hundredths ~/ 10;
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    final centiseconds = hundredths % 10;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${centiseconds.toString()}';
  }

  void start(void Function() update) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      hundredths++;
      update();
    });
    running = true;
    paused = false;
    AppLogger.log('Timer.start -> $formattedTime');
  }

  void pause(void Function() update) {
    _timer?.cancel();
    paused = true;
    running = false;
    AppLogger.log('Timer.pause -> $formattedTime');
    update();
  }

  void resume(void Function() update) {
    if (!paused) return;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      hundredths++;
      update();
    });
    running = true;
    paused = false;
    AppLogger.log('Timer.resume -> $formattedTime');
  }

  void reset(void Function() update) {
    _timer?.cancel();
    hundredths = 0;
    running = false;
    paused = false;
    AppLogger.log('Timer.reset -> $formattedTime');
    update();
  }

  void dispose() {
    _timer?.cancel();
  }
}
