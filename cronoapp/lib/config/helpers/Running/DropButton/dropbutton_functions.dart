import 'package:cronoapp/config/storage/chrono_db.dart';
import 'package:cronoapp/domain/entities/person_model.dart';
import 'package:cronoapp/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<int> deleteConfig(PersonConfig person) async {
  final element = await DB.deleteConfig(person);
  return element;
}

void setCicles(WidgetRef ref, PersonConfig person) {
  ref.read(currentConfig.notifier).state = person;
  ref.read(configSelected.notifier).state = person.id - 1;

  ref.read(secsBreak.notifier).state = person.breakDurationTime.split(":")[1];
  ref.read(minsBreak.notifier).state = person.breakDurationTime.split(":")[0];
  ref.read(secsExercise.notifier).state =
      person.exerciseDurationTime.split(":")[1];
  ref.read(minsExercise.notifier).state =
      person.exerciseDurationTime.split(":")[0];
  ref.read(cyclesAmount.notifier).state = person.cycles;
  ref.read(showButton.notifier).state = true;
}

Future<List<PersonConfig>> getConfigs(WidgetRef ref) async {
  final myList = DB.getCustoms();
  final myData = await myList;
  ref.read(myDataProvider.notifier).state = myData;
  return myList;
}
