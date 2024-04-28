import 'package:cronoapp/config/helpers/Running/DropButton/dropbutton_functions.dart';
import 'package:cronoapp/domain/entities/person_model.dart';
import 'package:cronoapp/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DropButtonWidget extends ConsumerWidget {
  final BoxConstraints myConstrains;

  const DropButtonWidget({super.key, required this.myConstrains});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<PersonConfig> myData = ref.watch(myDataProvider);
    final selected = ref.watch(configSelected);
    final theme = Theme.of(context).buttonTheme.colorScheme;

    return FutureBuilder(
      future: getConfigs(ref),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SizedBox(
              width: myConstrains.maxWidth / 2,
              child: const CircularProgressIndicator());
        } else {
          myData = snapshot.data!;
          if (myData.isEmpty) {
            return SizedBox(
              width: myConstrains.maxWidth / 2,
              child: Text(
                "No existen datos guardados",
                style: TextStyle(fontSize: myConstrains.maxWidth * 0.03),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return SizedBox(
              height: myConstrains.maxHeight * 0.07,
              width: myConstrains.maxWidth / 2,
              child: PopupMenuButton(
                color: theme!.inversePrimary,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadiusDirectional.all(
                      Radius.elliptical(15, 15),
                    ),
                    color: theme.primary,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: myConstrains.maxWidth * 0.02,
                    ),
                    child: SizedBox(
                      height: myConstrains.maxHeight * 0.07,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              myData[selected].title,
                              style: TextStyle(
                                color: theme.surface,
                                fontSize: myConstrains.maxWidth * 0.04,
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
