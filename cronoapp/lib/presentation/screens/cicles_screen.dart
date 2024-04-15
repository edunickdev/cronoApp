import 'package:cronoapp/presentation/shared/custom_navbar.dart';
import 'package:flutter/material.dart';

class CiclesScreen extends StatelessWidget {
  static const name = "/cicles";

  const CiclesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: CustomNavBarWidget(),
      body: Placeholder(),
    );
  }
}
