import 'package:cronoapp/presentation/screens/cicles_screen.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/home_screen.dart';

final routes = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const HomeScreen(),
      name: HomeScreen.name,
    ),
    GoRoute(
      path: "/cicles",
      builder: (context, state) => const CiclesScreen(),
      name: CiclesScreen.name,
    ),
  ],
);
