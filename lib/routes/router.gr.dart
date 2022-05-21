// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:bshare/Screens/ForgetPassword.dart' as _i2;
import 'package:bshare/Screens/Home.dart' as _i5;
import 'package:bshare/Screens/SignIn.dart' as _i4;
import 'package:bshare/Screens/SignUp.dart' as _i3;
import 'package:bshare/Screens/StartPage.dart' as _i1;
import 'package:flutter/material.dart' as _i7;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    FirstPageRoute.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.FirstPage());
    },
    ForgetPasswordRoute.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.ForgetPassword());
    },
    SingUpRoute.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.SingUp());
    },
    SignInRoute.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i4.SignIn());
    },
    HomeRoute.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(routeData: routeData, child: _i5.Home());
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig('/#redirect',
            path: '/', redirectTo: '/firstpage', fullMatch: true),
        _i6.RouteConfig(FirstPageRoute.name, path: '/firstpage', children: [
          _i6.RouteConfig('*#redirect',
              path: '*',
              parent: FirstPageRoute.name,
              redirectTo: '',
              fullMatch: true)
        ]),
        _i6.RouteConfig(ForgetPasswordRoute.name,
            path: '/forgetPassword',
            children: [
              _i6.RouteConfig('*#redirect',
                  path: '*',
                  parent: ForgetPasswordRoute.name,
                  redirectTo: '',
                  fullMatch: true)
            ]),
        _i6.RouteConfig(SingUpRoute.name, path: '/signup', children: [
          _i6.RouteConfig('*#redirect',
              path: '*',
              parent: SingUpRoute.name,
              redirectTo: '',
              fullMatch: true)
        ]),
        _i6.RouteConfig(SignInRoute.name, path: '/signin', children: [
          _i6.RouteConfig('*#redirect',
              path: '*',
              parent: SignInRoute.name,
              redirectTo: '',
              fullMatch: true)
        ]),
        _i6.RouteConfig(HomeRoute.name, path: '/home', children: [
          _i6.RouteConfig('*#redirect',
              path: '*',
              parent: HomeRoute.name,
              redirectTo: '',
              fullMatch: true)
        ])
      ];
}

/// generated route for
/// [_i1.FirstPage]
class FirstPageRoute extends _i6.PageRouteInfo<void> {
  const FirstPageRoute({List<_i6.PageRouteInfo>? children})
      : super(FirstPageRoute.name,
            path: '/firstpage', initialChildren: children);

  static const String name = 'FirstPageRoute';
}

/// generated route for
/// [_i2.ForgetPassword]
class ForgetPasswordRoute extends _i6.PageRouteInfo<void> {
  const ForgetPasswordRoute({List<_i6.PageRouteInfo>? children})
      : super(ForgetPasswordRoute.name,
            path: '/forgetPassword', initialChildren: children);

  static const String name = 'ForgetPasswordRoute';
}

/// generated route for
/// [_i3.SingUp]
class SingUpRoute extends _i6.PageRouteInfo<void> {
  const SingUpRoute({List<_i6.PageRouteInfo>? children})
      : super(SingUpRoute.name, path: '/signup', initialChildren: children);

  static const String name = 'SingUpRoute';
}

/// generated route for
/// [_i4.SignIn]
class SignInRoute extends _i6.PageRouteInfo<void> {
  const SignInRoute({List<_i6.PageRouteInfo>? children})
      : super(SignInRoute.name, path: '/signin', initialChildren: children);

  static const String name = 'SignInRoute';
}

/// generated route for
/// [_i5.Home]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
      : super(HomeRoute.name, path: '/home', initialChildren: children);

  static const String name = 'HomeRoute';
}
