import 'package:firebase_riverpod/ui/auth/providers/auth_view_model_provider.dart';
import 'package:firebase_riverpod/ui/components/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../root.dart';

class EmailVerifyPage extends ConsumerWidget {
  const EmailVerifyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final styles = theme.textTheme;
    final model = ref.read(AuthViewModelProvider);

    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          onPressed: () async {
            await model.logout();
          },
          icon: Icon(Icons.logout),
        ),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Verifica tu correo",
              style: styles.headlineLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              "Link de verificacion enviado al correo ${model.user!.email}",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await model.reload();
                  if (model.user!.emailVerified) {
                    Navigator.pushReplacementNamed(context, Root.route);
                  } else {
                    AppSnackBar(context).error("Correo no verificado");
                  }
                },
                child: Text("Done"),
              ),
            ),
            Center(
              child: ElevatedButton(
                child: Text("Reenviar"),
                onPressed: () async {
                  model.sendEmail();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
