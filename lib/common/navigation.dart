import 'package:go_router/go_router.dart';
import 'package:submission_intermediate/screens/add_story_screen.dart';
import 'package:submission_intermediate/screens/detail_screen.dart';
import 'package:submission_intermediate/screens/home_screen.dart';
import 'package:submission_intermediate/screens/login_screen.dart';
import 'package:submission_intermediate/screens/register_screen.dart';
import 'package:submission_intermediate/screens/splash_screen.dart';
import 'package:submission_intermediate/screens/welcome_screen.dart';

class Navigation {
  static const splash = 'splash';
  static const welcome = 'welcome';
  static const home = 'home';
  static const login = 'login';
  static const register = 'register';
  static const detailStory = 'detail_story';
  static const addStory = 'add_story';

  static final router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
          path: '/welcome',
          name: welcome,
          builder: (context, state) => const WelcomeScreen(),
          routes: [
            GoRoute(
              path: 'login',
              name: login,
              builder: (context, state) => const LoginScreen(),
            ),
            GoRoute(
              path: 'register',
              name: register,
              builder: (context, state) => const RegisterScreen(),
            ),
          ]),
      GoRoute(
        path: '/',
        name: home,
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'add_story',
            name: addStory,
            builder: (context, state) => const AddStoryScreen(),
          ),
          GoRoute(
            path: 'story/:id',
            name: detailStory,
            builder: (context, state) {
              final id = state.pathParameters['id'].toString();
              return DetailScreen(id: id);
            },
          ),
        ],
      ),
    ],
  );
}
