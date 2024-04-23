class NewConfig {
  final String title;
  final String exerciseDurationTime;
  final String breakDurationTime;
  final int cycles;

  NewConfig(
      {required this.title,
      required this.exerciseDurationTime,
      required this.breakDurationTime,
      required this.cycles});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'exerciseDurationTime': exerciseDurationTime,
      'breakDurationTime': breakDurationTime,
      'cycles': cycles,
    };
  }
}
