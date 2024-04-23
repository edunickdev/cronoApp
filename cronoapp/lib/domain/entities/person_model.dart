class PersonConfig {
  final int id;
  final String title;
  final String exerciseDurationTime;
  final String breakDurationTime;
  final int cycles;

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

  set setId(int id) => id;
  set setTitle(String title) => title;
  set setExerciseDurationTime(String exerciseDurationTime) => exerciseDurationTime;
  set setBreakDurationTime(String breakDurationTime) => breakDurationTime;
  set setCycles(int cycles) => cycles;

  factory PersonConfig.fromMap(Map<String, dynamic> map){
    return PersonConfig(
      id: map['id'],
      title: map['title'],
      exerciseDurationTime: map['exerciseDurationTime'],
      breakDurationTime: map['breakDurationTime'],
      cycles: map['cycles'],
    );
  }


}
