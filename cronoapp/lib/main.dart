import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cronoapp/presentation/screens/cicles_screen.dart';
import 'package:cronoapp/presentation/screens/home_screen.dart';
import 'package:cronoapp/presentation/shared/custom_navbar.dart';
import 'package:cronoapp/providers.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> screens = [const HomeScreen(), const CiclesScreen()];
    final int currentScreen = ref.watch(selectScreen);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CronoApp',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.amber[600]),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        body: screens[currentScreen],
        bottomNavigationBar: const CustomNavBarWidget(),
        floatingActionButton: currentScreen == 1
            ? FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.keyboard_double_arrow_up_rounded))
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
