import 'package:cronoapp/config/storage/chrono_db.dart';
import 'package:cronoapp/config/storage/storage_functions.dart';
import 'package:cronoapp/domain/entities/person_model.dart';
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

    List<PersonConfig> myData = [];

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
              print("mi variable data $myData");
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
                    items: myData
                        .map(
                          (e) => DropdownMenuItem(
                            child: Text(
                              e.title,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {},
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
