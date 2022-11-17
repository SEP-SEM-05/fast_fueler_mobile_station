import 'package:fast_fueler_mobile_station/common/widgets/bottom_bar.dart';
import 'package:fast_fueler_mobile_station/screens/auth/signin_screen.dart';
import 'package:fast_fueler_mobile_station/screens/distribution/distribution_screen.dart';
import 'package:fast_fueler_mobile_station/screens/distribution/qr_screen.dart';
import 'package:fast_fueler_mobile_station/screens/home/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SigninScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SigninScreen(),
      );

    case DashboardScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const DashboardScreen(),
      );

    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );

    case QRScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const QRScreen(),
      );

    case DistributionScreen.routeName:
      var screenClosed = routeSettings.arguments as Function();
      var value = routeSettings.arguments as Barcode; 
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => DistributionScreen(value: value, screenClosed: screenClosed),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
