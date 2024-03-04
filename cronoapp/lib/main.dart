import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/router/app_router.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'CronoApp',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.amber[600]),
      darkTheme: ThemeData.dark(),
      routerConfig: routes
    );
  }
}

