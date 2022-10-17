import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_riverpod/root.dart';
import 'package:firebase_riverpod/router.dart';
import 'package:firebase_riverpod/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(seedColor: Colors.yellow);
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: colorScheme,
          primaryColor: colorScheme.primary,
          buttonTheme: ButtonThemeData(
              shape: StadiumBorder(), textTheme: ButtonTextTheme.primary),
          textTheme: TextTheme(
            headlineLarge: TextStyle(fontWeight: FontWeight.bold),
          ),
          inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 20))),
      //*Pagina Inicial
      initialRoute: SplashScreen.route,

      //*Rutas
      onGenerateRoute: AppRouter.onNavigate,
    );
  }
}
