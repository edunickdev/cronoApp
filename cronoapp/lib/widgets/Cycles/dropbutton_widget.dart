import 'package:cronoapp/config/helpers/Running/DropButton/dropbutton_functions.dart';
import 'package:cronoapp/domain/entities/person_model.dart';
import 'package:cronoapp/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DropButtonWidget extends ConsumerWidget {
  const DropButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<PersonConfig> myData = ref.watch(myDataProvider);
    final width = MediaQuery.of(context).size.width;
    final selected = ref.watch(configSelected);
    final theme = Theme.of(context).buttonTheme.colorScheme;

    return FutureBuilder(
      future: getConfigs(ref),
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
              child: PopupMenuButton(
                color: theme!.inversePrimary,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadiusDirectional.all(
                      Radius.elliptical(10, 10),
                    ),
                    color: theme.primary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            myData[selected].title,
                            style: TextStyle(
                              color: theme.surface,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                itemBuilder: (BuildContext context) {
                  return myData
                      .map(
                        (conf) => PopupMenuItem(
                          value: conf.id,
                          onTap: () => setCicles(ref, conf),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  conf.title,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  deleteConfig(conf);
                                  getConfigs(ref);
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(
                                  Icons.delete_forever_rounded,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList();
                },
              ),
            );
          }
        }
      },
    );
  }
}
