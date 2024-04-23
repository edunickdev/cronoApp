import 'package:cronoapp/config/helpers/Cycles/cycle_functions.dart';
import 'package:cronoapp/config/storage/chrono_db.dart';
import 'package:cronoapp/domain/entities/new_config_model.dart';
import 'package:cronoapp/providers.dart';
import 'package:cronoapp/widgets/Cycles/section_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<String> savePersonConfig(WidgetRef ref) async {
  final currentMinutesE = ref.watch(minsExercise);
  final currentSecondsE = ref.watch(secsExercise);
  final currentMinutesB = ref.watch(minsBreak);
  final currentsecondsB = ref.watch(secsBreak);
  final currentCycles = ref.watch(cyclesAmount);
  final currentTitle = ref.watch(titleConfig);

  if (currentTitle != "") {
    if (currentCycles != 0) {
      if (currentMinutesE != "00" || currentSecondsE != "00") {
        if (currentsecondsB != "00" || currentMinutesB != "00") {

          final newData = NewConfig(
            title: currentTitle,
            exerciseDurationTime: "$currentMinutesE:$currentSecondsE",
            breakDurationTime: "$currentMinutesB:$currentsecondsB",
            cycles: currentCycles,
          );
          
          await DB.addConfig(newData);
          resetTimers(ref, MyOptions.all);
          return "Se realizo registro correctamente ${newData.title}";
        } else {
          return "Faltan datos en Descanso";
        }
      } else {
        return "Faltan datos en Ejercicio";
      }
    } else {
      return "La cantidad de ciclos debe ser al menos igual a 1";
    }
  } else {
    return "Debe definir un título";
  }
}
