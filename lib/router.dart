import 'package:firebase_riverpod/root.dart';
import 'package:firebase_riverpod/ui/auth/register_page.dart';
import 'package:firebase_riverpod/ui/items/write_item_page.dart';
import 'package:firebase_riverpod/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<MaterialPageRoute> onNavigate(RouteSettings settings) {
    late final Widget selectedPage;

    switch (settings.name) {
      case SplashScreen.route:
        selectedPage = SplashScreen();
        break;
      case RegisterPage.route:
        selectedPage = RegisterPage();
        break;
      case WriteItemPage.route:
        selectedPage = WriteItemPage();
        break;

      //**Pagina por defecto */
      default:
        selectedPage = Root();
        break;
    }

    return MaterialPageRoute(builder: (context) => selectedPage);
  }
}
