import 'dart:async';

import 'package:cronoapp/domain/entities/person_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectScreen = StateProvider<int>((ref) => 0);

final mainMode = StateProvider<bool>((ref) => false);
final mainHours = StateProvider<String>((ref) => "00");
final mainMinutes = StateProvider<String>((ref) => "00");
final mainSeconds = StateProvider<String>((ref) => "00");
final mainmiliSeconds = StateProvider<String>((ref) => "00");
final mainIsRunning = StateProvider<bool>((ref) => false);

final minsExercise = StateProvider<String>((ref) => "00");
final secsExercise = StateProvider<String>((ref) => "00");
final minsBreak = StateProvider<String>((ref) => "00");
final secsBreak = StateProvider<String>((ref) => "00");
final moments = StateProvider<int>((ref) => 0);
final cyclesAmount = StateProvider<int>((ref) => 0);
final objectCycles = StateProvider<List<List<int>>>((ref) => []);
final totalBreakTime = StateProvider<int>((ref) => 0);
final totalExerciseTime = StateProvider<int>((ref) => 0);

final configSelected = StateProvider<int>((ref) => 0);
final myConfigList = StateProvider<List<String>?>((ref) => []);
final titleConfig = StateProvider((ref) => "");

final currentConfig = StateProvider<PersonConfig>(
  (ref) => PersonConfig(
    id: 0,
    title: "",
    exerciseDurationTime: "",
    breakDurationTime: "",
    cycles: 0,
  ),
);

final showButton = StateProvider<bool>((ref) => false);
final myBrightness = StateProvider<bool>((ref) => true);
final myTheme = StateProvider<int>((ref) => 4);

final myDataProvider = StateProvider<List<PersonConfig>>((ref) => []);
final myTimer = StateProvider<Timer>(
  (ref) => Timer.periodic(const Duration(milliseconds: 10), (timer) {}),
);
