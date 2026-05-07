import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../views/screens/login_screen.dart';
import '../../views/screens/register_screen.dart';
import '../../views/screens/home_screen.dart';
import '../../views/screens/add_edit_task_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',

  redirect: (context, state) {
    final user = FirebaseAuth.instance.currentUser;

    final isAuthPage =
        state.matchedLocation == '/login' ||
        state.matchedLocation == '/register';

    // Not logged in → go to login
    if (user == null && !isAuthPage) {
      return '/login';
    }

    // Logged in → skip login/register
    if (user != null && isAuthPage) {
      return '/home';
    }

    return null;
  },

  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/add-task',
      builder: (context, state) => const AddEditTaskScreen(),
    ),
  ],
);