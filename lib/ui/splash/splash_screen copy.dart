import 'package:firebase_riverpod/root.dart';
import 'package:firebase_riverpod/ui/utils/labels.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const String route = "/splash";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    //*Despues de dos segundos redirigir al Login
    Future.delayed(Duration(seconds: 2)).whenComplete(() {
      Navigator.pushNamedAndRemoveUntil(context, Root.route, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final styles = theme.textTheme;
    return Scaffold(
      backgroundColor: scheme.primaryContainer,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.favorite,
              size: 80,
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              Labels.appName,
              style: styles.headlineLarge!
                  .copyWith(color: scheme.onPrimaryContainer),
            )
          ],
        ),
      ),
    );
  }
}
