import 'package:auto_route/auto_route.dart';
import 'package:bshare/Screens/ForgetPassword.dart';
import 'package:bshare/Screens/Home.dart';
import 'package:bshare/Screens/SignIn.dart';
import 'package:bshare/Screens/SignUp.dart';
import 'package:bshare/Screens/StartPage.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route,Screen',
  routes: <AutoRoute>[
    //First Page Route
    AutoRoute(
      initial: true,
      path: '/firstpage',
      page: FirstPage,
      children: [
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),

    //
    AutoRoute(
      path: '/forgetPassword',
      page: ForgetPassword,
      children: [
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),

    // SingUp Route
    AutoRoute(
      path: '/signup',
      page: SingUp,
      children: [
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),

    //SingIn Route
    AutoRoute(
      path: '/signin',
      page: SignIn,
      children: [
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),

    //Home route
    AutoRoute(
      path: '/home',
      page: Home,
      children: [
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    )
  ],
)
class $AppRouter {}
