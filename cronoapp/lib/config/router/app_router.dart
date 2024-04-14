import 'package:go_router/go_router.dart';

import '../../presentation/screens/home_screen.dart';

final routes = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const HomeScreen(),
      name: HomeScreen.name,
    ),
    // GoRoute(
    //   path: "/cicles",
    //   builder: (context, state) => const HomeScreen(),
    //   name: HomeScreen.name,
    // ),
  ],
);
