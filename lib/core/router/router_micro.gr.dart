// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:crud_list/presentation/flutter_bloc/pages/home_bloc_page.dart'
    as _i1;
import 'package:crud_list/presentation/flutter_provider/pages/home_provider_page.dart'
    as _i3;
import 'package:crud_list/presentation/flutter_riverpod/pages/home_riverpod_page.dart'
    as _i4;
import 'package:crud_list/presentation/home/pages/home_page.dart' as _i2;
import 'package:crud_list/presentation/splash/pages/splash_page.dart' as _i5;

/// generated route for
/// [_i1.HomeBlocPage]
class HomeBlocRoute extends _i6.PageRouteInfo<void> {
  const HomeBlocRoute({List<_i6.PageRouteInfo>? children})
      : super(
          HomeBlocRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeBlocRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomeBlocPage();
    },
  );
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomePage();
    },
  );
}

/// generated route for
/// [_i3.HomeProviderPage]
class HomeProviderRoute extends _i6.PageRouteInfo<void> {
  const HomeProviderRoute({List<_i6.PageRouteInfo>? children})
      : super(
          HomeProviderRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeProviderRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomeProviderPage();
    },
  );
}

/// generated route for
/// [_i4.HomeRiverpodPage]
class HomeRiverpodRoute extends _i6.PageRouteInfo<void> {
  const HomeRiverpodRoute({List<_i6.PageRouteInfo>? children})
      : super(
          HomeRiverpodRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRiverpodRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i4.HomeRiverpodPage();
    },
  );
}

/// generated route for
/// [_i5.SplashPage]
class SplashRoute extends _i6.PageRouteInfo<void> {
  const SplashRoute({List<_i6.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i5.SplashPage();
    },
  );
}
