import 'package:cronoapp/config/storage/chrono_db.dart';
import 'package:cronoapp/config/storage/storage_functions.dart';
import 'package:cronoapp/domain/entities/person_model.dart';
import 'package:cronoapp/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomDropdownWidget extends ConsumerWidget {
  const CustomDropdownWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;

    Future<SnackBar> resultSnackbar() async {
      final response = await savePersonConfig(ref);

      final snackResponse = SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(response),
        duration: const Duration(milliseconds: 1200),
        backgroundColor: response.contains("ciclo") ||
                response.contains("ejercicio") ||
                response.contains("descanso")
            ? Colors.redAccent
            : Colors.green[400],
      );

      return snackResponse;
    }

    Future<List<PersonConfig>> getConfigs() async {
      final myList = DB.getCustoms();
      return myList;
    }

    void setCicles(WidgetRef ref, PersonConfig person){
      print("ingreso a funcion");

      final tempBS = person.breakDurationTime.split(":")[1];
      final tempBM = person.breakDurationTime.split(":")[0];
      final tempES = person.breakDurationTime.split(":")[1];
      final tempEM = person.breakDurationTime.split(":")[0];

      print(tempBS);
      print(tempEM);
      print(tempES);
      print(tempBM);

      ref.read(secsBreak.notifier).state = "00";
      ref.read(minsBreak.notifier).state = "00";
      ref.read(secsExercise.notifier).state = "00";
      ref.read(minsExercise.notifier).state = "00";
    }

    List<PersonConfig> myData = [];

    final selected = ref.watch(configSelected);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            resultSnackbar().then(
              (snackbar) => {
                ScaffoldMessenger.of(context).showSnackBar(snackbar),
              },
            );
          },
          icon: const Icon(Icons.save),
          label: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text("Guardar"),
          ),
        ),
        const SizedBox(width: 10),
        FutureBuilder(
          future: getConfigs(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            } else {
              myData = snapshot.data!;
              if (myData.isEmpty) {
                return SizedBox(
                  width: width / 2,
                  child: const Center(
                    child: Text("No existen datos guardados"),
                  ),
                );
              } else {
                return SizedBox(
                  width: width / 2,
                  child: DropdownButton(
                    value: selected,
                    items: myData
                        .map(
                          (conf) => DropdownMenuItem(
                            onTap: () => setCicles(ref, conf),
                            value: conf.id,
                            child: Text(
                              conf.title,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      ref.read(configSelected.notifier).state = value!;
                    },
                  ),
                );
              }
            }
          },
        ),
      ],
    );
  }
}
