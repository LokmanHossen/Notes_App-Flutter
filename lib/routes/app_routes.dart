// import 'package:get/get.dart';
// import 'package:go_router/go_router.dart';
// import 'package:notes_app/ui/home_page.dart';
// import 'package:notes_app/ui/login_page.dart';
// import 'package:notes_app/ui/sign_up_page.dart';
// import 'package:notes_app/ui/splash_screen.dart';

// // import 'package:notes_app/ui/splash_screen.dart';

// class MyRoutes {
//   static const String splash = '/';
//   static String login = '/login';
//   static String register = '/register';
//   static String home = '/home';
// }

// var goRouter = GoRouter(
//   navigatorKey: Get.key,
//   routes: [
//     GoRoute(
//       path: MyRoutes.splash,
//       builder: (context, state) => const SplashScreen(),
//       // pageBuilder: (context, state) =>
//       //     const MaterialPage(child: SplashScreen()),
//     ),
//     GoRoute(
//       path: MyRoutes.login,
//       // pageBuilder: (context, state) => const MaterialPage(child: LoginScreen()),
//       builder: (context, state) => const LoginScreen(),
//     ),
//     GoRoute(
//       path: MyRoutes.register,
//       // pageBuilder: (context, state) =>
//       // const MaterialPage(child: RegisterScreen()),
//       builder: (context, state) => const RegisterScreen(),
//     ),
//     GoRoute(
//       path: MyRoutes.home,
//       // pageBuilder: (context, state) => const MaterialPage(child: HomeScreen()),
//       builder: (context, state) => const HomeScreen(),
//     ),
//   ],
//   // errorPageBuilder: (context, state) {
//   //   return const MaterialPage(child: ErrorPage());
//   // },
// );
