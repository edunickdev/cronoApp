class PersonConfig {
  final int id;
  final String title;
  final String exerciseDurationTime;
  final String breakDurationTime;
  final int    cycles;

  PersonConfig({
    required this.id,
    required this.title,
    required this.exerciseDurationTime,
    required this.breakDurationTime,
    required this.cycles,
  });

  
  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'title': title,
      'exerciseDurationTime': exerciseDurationTime,
      'breakDurationTime': breakDurationTime,
      'cycles': cycles,
    };
  }


}
