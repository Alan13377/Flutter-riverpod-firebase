import 'package:firebase_riverpod/ui/auth/email_verify.dart';
import 'package:firebase_riverpod/ui/auth/login_page.dart';
import 'package:firebase_riverpod/ui/auth/providers/auth_view_model_provider.dart';
import 'package:firebase_riverpod/ui/home/home_page.dart';
import 'package:firebase_riverpod/ui/onBoarding/onboarding_page.dart';
import 'package:firebase_riverpod/ui/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ui/providers/cache_provider.dart';

// class Root extends ConsumerWidget {
//   static const String route = "/";
//   const Root({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     //*Leemos el provier
//     final seen =
//         ref.read(cacheProvider).value!.getBool(Constants.seen) ?? false;
//     final auth = ref.read(AuthViewModelProvider);
//     return !seen
//         ? OnBoardingPage()
//         : auth.user != null
//             ? auth.user!.emailVerified
//                 ? HomePage()
//                 : EmailVerifyPage()
//             : LoginPage();
//   }
// }

class Root extends ConsumerWidget {
  static const String route = "/";
  const Root({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //*Leemos el provier
    final auth = ref.read(AuthViewModelProvider);
    return auth.user != null
        ? auth.user!.emailVerified
            ? HomePage()
            : EmailVerifyPage()
        : LoginPage();
  }
}
