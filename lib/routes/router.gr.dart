// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint
import 'package:bshare/Screens/Upload.dart' as _i10;
import 'package:bshare/Screens/ProfileScreen/MyProfileSettings.dart' as _i8;
import 'package:bshare/Screens/ProfileScreen/Settings.dart' as _i7;
import 'package:bshare/Screens/Settings/ProfileEdit.dart' as _i9;
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:bshare/Screens/Home.dart' as _i4;
import 'package:bshare/Screens/SignIn.dart' as _i3;
import 'package:bshare/Screens/SignUp.dart' as _i2;
import 'package:bshare/Screens/StartPage.dart' as _i1;
import 'package:flutter/material.dart' as _i6;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    FirstPageRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.FirstPage());
    },
    SingUpRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.SingUp());
    },
    SignInRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.SignIn());
    },
    HomeRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(routeData: routeData, child: _i4.Home());
    },
    SettingsRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: _i7.Settings());
    },
    MyProfileSettingsRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: _i8.MyProfileSettings());
    },
    ProfileEditRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: _i9.ProfileEdit());
    },
    UploadRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: _i10.Upload());
    }
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig('/#redirect',
            path: '/', redirectTo: '/firstpage', fullMatch: true),
        _i5.RouteConfig(FirstPageRoute.name, path: '/firstpage', children: [
          _i5.RouteConfig('*#redirect',
              path: '*',
              parent: FirstPageRoute.name,
              redirectTo: '',
              fullMatch: true)
        ]),
        _i5.RouteConfig(SingUpRoute.name, path: '/signup', children: [
          _i5.RouteConfig('*#redirect',
              path: '*',
              parent: SingUpRoute.name,
              redirectTo: '',
              fullMatch: true)
        ]),
        _i5.RouteConfig(SignInRoute.name, path: '/signin', children: [
          _i5.RouteConfig('*#redirect',
              path: '*',
              parent: SignInRoute.name,
              redirectTo: '',
              fullMatch: true)
        ]),
        _i5.RouteConfig(HomeRoute.name, path: '/home', children: [
          _i5.RouteConfig('*#redirect',
              path: '*',
              parent: HomeRoute.name,
              redirectTo: '',
              fullMatch: true)
        ]),
        _i5.RouteConfig(SettingsRoute.name, path: '/settings', children: [
          _i5.RouteConfig('*#redirect',
              path: '*',
              parent: SettingsRoute.name,
              redirectTo: '',
              fullMatch: true)
        ]),
        _i5.RouteConfig(MyProfileSettingsRoute.name,
            path: '/myProfileSettings',
            children: [
              _i5.RouteConfig('*#redirect',
                  path: '*',
                  parent: MyProfileSettingsRoute.name,
                  redirectTo: '',
                  fullMatch: true)
            ]),
        _i5.RouteConfig(ProfileEditRoute.name, path: '/profileEdit', children: [
          _i5.RouteConfig('*#redirect',
              path: '*',
              parent: ProfileEditRoute.name,
              redirectTo: '',
              fullMatch: true)
        ]),
        _i5.RouteConfig(UploadRoute.name, path: '/upload', children: [
          _i5.RouteConfig('*#redirect',
              path: '*',
              parent: UploadRoute.name,
              redirectTo: '',
              fullMatch: true)
        ]),
      ];
}

/// generated route for
/// [_i1.FirstPage]
class FirstPageRoute extends _i5.PageRouteInfo<void> {
  const FirstPageRoute({List<_i5.PageRouteInfo>? children})
      : super(FirstPageRoute.name,
            path: '/firstpage', initialChildren: children);

  static const String name = 'FirstPageRoute';
}

/// generated route for
/// [_i2.SingUp]
class SingUpRoute extends _i5.PageRouteInfo<void> {
  const SingUpRoute({List<_i5.PageRouteInfo>? children})
      : super(SingUpRoute.name, path: '/signup', initialChildren: children);

  static const String name = 'SingUpRoute';
}

/// generated route for
/// [_i3.SignIn]
class SignInRoute extends _i5.PageRouteInfo<void> {
  const SignInRoute({List<_i5.PageRouteInfo>? children})
      : super(SignInRoute.name, path: '/signin', initialChildren: children);

  static const String name = 'SignInRoute';
}

/// generated route for
/// [_i4.Home]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(HomeRoute.name, path: '/home', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i7.Settings]
class SettingsRoute extends _i5.PageRouteInfo<void> {
  const SettingsRoute({List<_i5.PageRouteInfo>? children})
      : super(SettingsRoute.name, path: '/settings', initialChildren: children);

  static const String name = 'SettingsRoute';
}

/// generated route for
/// [_i8.MyProfileSettings]
class MyProfileSettingsRoute extends _i5.PageRouteInfo<void> {
  const MyProfileSettingsRoute({List<_i5.PageRouteInfo>? children})
      : super(MyProfileSettingsRoute.name,
            path: '/myProfileSettings', initialChildren: children);

  static const String name = 'MyProfileSettingsRoute';
}

/// generated route for
/// [_i9.ProfileEdit]
class ProfileEditRoute extends _i5.PageRouteInfo<void> {
  const ProfileEditRoute({List<_i5.PageRouteInfo>? children})
      : super(ProfileEditRoute.name,
            path: '/profileEdit', initialChildren: children);

  static const String name = 'ProfileEditRoute';
}

/// generated route for
/// [_i10.Upload]
class UploadRoute extends _i5.PageRouteInfo<void> {
  const UploadRoute({List<_i5.PageRouteInfo>? children})
      : super(UploadRoute.name, path: '/upload', initialChildren: children);

  static const String name = 'UploadRoute';
}
