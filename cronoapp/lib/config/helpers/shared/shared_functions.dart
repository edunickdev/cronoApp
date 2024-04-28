import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cronoapp/providers.dart';

Timer resetTime(WidgetRef ref, Timer timer) {
  timer.cancel();
  ref.read(mainIsRunning.notifier).state = false;
  ref.read(mainHours.notifier).state = "00";
  ref.read(mainMinutes.notifier).state = "00";
  ref.read(mainSeconds.notifier).state = "00";
  ref.read(mainmiliSeconds.notifier).state = "00";

  return timer;
}

Timer pauseTime(WidgetRef ref, Timer timer) {
  timer.cancel();
  ref.read(mainIsRunning.notifier).state = false;
  return timer;
}
