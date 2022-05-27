import 'package:auto_route/auto_route.dart';
import 'package:bshare/Screens/Home.dart';
import 'package:bshare/Screens/IconNavigationScreens/BookDetails.dart';
import 'package:bshare/Screens/IconNavigationScreens/ProfileScreen.dart';
import 'package:bshare/Screens/ProfileScreen/MyProfileSettings.dart';
import 'package:bshare/Screens/ProfileScreen/Settings.dart';
import 'package:bshare/Screens/Settings/ProfileEdit.dart';
import 'package:bshare/Screens/SignIn.dart';
import 'package:bshare/Screens/SignUp.dart';
import 'package:bshare/Screens/StartPage.dart';
import 'package:bshare/Screens/Upload.dart';

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
        AutoRoute(
          path: '/settings',
          page: Settings,
          children: [
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
        AutoRoute(
          path: '/BookDetail',
          page: BookDetails,
          children: [
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),

        //My Profile Settings route
        AutoRoute(
          path: '/myProfileSettings',
          page: MyProfileSettings,
          children: [
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),

        //My Profile Edit route
        AutoRoute(
          path: '/profileEdit',
          page: ProfileEdit,
          children: [
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),

        // My Profile Edit route
        AutoRoute(
          path: '/upload',
          page: Upload,
          children: [
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),

        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),

    //Settings route

    //
  ],
)
class $AppRouter {}
