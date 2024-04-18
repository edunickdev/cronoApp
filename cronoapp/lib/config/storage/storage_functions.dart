import 'package:cronoapp/config/storage/chrono_db.dart';
import 'package:cronoapp/domain/entities/person_model.dart';
import 'package:cronoapp/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void savePersonConfig(WidgetRef ref) async {
  final currentMinutesE = ref.watch(minsExercise);
  final currentSecondsE = ref.watch(secsExercise);
  final currentMinutesB = ref.watch(minsBreak);
  final currentsecondsB = ref.watch(secsBreak);
  final currentCycles = ref.watch(cyclesAmount);

  if (currentCycles > 0 && currentMinutesE != "00" ||
      currentSecondsE != "00" ||
      currentMinutesB != "00" ||
      currentsecondsB != "00") {

    final newData = PersonConfig(
      id: 1,
      title: "title",
      exerciseDurationTime: "$currentMinutesE:$currentSecondsE",
      breakDurationTime: "$currentMinutesB:$currentsecondsB",
      cycles: currentCycles,
    );

    final response = await DB.addConfig(newData);
    print(response);
  } else {
    print("oh no, no fue posible guardar base de datos");
  }
}
