import 'package:firebase_riverpod/root.dart';
import 'package:firebase_riverpod/ui/providers/cache_provider.dart';
import 'package:firebase_riverpod/ui/utils/labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  static const String route = "/splash";
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    init();
  }

  void init() async {
    //*leer sharedpreferences
    await ref.read(cacheProvider.future);
    await Future.delayed(Duration(seconds: 1));
    //*Despues de dos segundos redirigir al Login
    Navigator.pushNamedAndRemoveUntil(context, Root.route, (route) => false);
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

//////////////////////////////////////////7
