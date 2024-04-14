import 'package:flutter_riverpod/flutter_riverpod.dart';

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
final cycles = StateProvider<List<List<int>>>((ref) => []);
final totalBreakTime = StateProvider<int>((ref) => 0);
final totalExerciseTime = StateProvider<int>((ref) => 0);
