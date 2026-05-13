import 'package:go_router/go_router.dart';

import '../../views/screens/home_screen.dart';
import '../../views/screens/login_screen.dart';
import '../../views/screens/register_screen.dart';
import '../../views/screens/todo_grid_screen.dart';
import '../../views/screens/todo_list_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',

  routes: [

    GoRoute(
      path: '/home',

      builder: (context, state) {
        return const HomeScreen();
      },
    ),

    GoRoute(
      path: '/login',

      builder: (context, state) {
        return const LoginScreen();
      },
    ),

    GoRoute(
      path: '/register',

      builder: (context, state) {
        return const RegisterScreen();
      },
    ),

    GoRoute(
      path: '/todo-list',

      builder: (context, state) {
        return const TodoListScreen();
      },
    ),

    GoRoute(
      path: '/todo-board',

      builder: (context, state) {
        return const TodoGridScreen();
      },
    ),
  ],
);