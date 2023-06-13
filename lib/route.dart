import 'package:go_router/go_router.dart';

import './views/home.dart';
import './views/connection.dart';

GoRouter router() {
  return GoRouter(
    initialLocation: '/connection',
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, state) => const Home(),
      ),
      GoRoute(
        path: '/connection',
        builder: (context, state) => const Connection(),
      ),
    ],
  );
}
