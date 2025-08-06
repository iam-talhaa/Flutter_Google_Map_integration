import 'package:flutter/material.dart';
import 'package:flutter_google_map_integration/View/map_home.dart';
import 'package:flutter_google_map_integration/utils/Routes.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    final argumen = setting.arguments;
    switch (setting.name) {
      case RouteName.Homepage:
        return MaterialPageRoute(
          builder: (BuildContext context) => HomeScreen(),
        );
      case RouteName.LoginScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => HomeScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return Scaffold(body: Text('NO Routes Defined'));
          },
        );
    }
  }
}
