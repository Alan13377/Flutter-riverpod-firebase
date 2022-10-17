import 'package:firebase_riverpod/root.dart';
import 'package:firebase_riverpod/ui/auth/providers/auth_view_model_provider copy.dart';
import 'package:firebase_riverpod/ui/auth/register_page.dart';
import 'package:firebase_riverpod/ui/components/snackbar.dart';
import 'package:firebase_riverpod/ui/utils/labels.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  static const String route = "/login";
  final _formKey = GlobalKey<FormState>();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final styles = theme.textTheme;

    //*Escuchamos el provider
    final model = ref.watch(AuthViewModelProvider);
    return Stack(
      children: [
        Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  Icon(
                    Icons.favorite,
                    size: 80,
                    color: scheme.tertiary,
                  ),
                  const Spacer(),
                  Text(
                    Labels.signIn,
                    style: styles.headlineLarge,
                  ),
                  const SizedBox(
                    height: 24,
                  ),

                  //**FORMULARIO EMAIL */
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      prefixIcon: const Icon(Icons.email_outlined),
                      label: Text(Labels.email),
                    ),
                    onChanged: (value) => model.email = value,
                    validator: (value) => model.emailValidate(value.toString()),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    obscureText: model.obscurePassword,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_clock_outlined),
                      label: Text(Labels.password),
                      suffixIcon: IconButton(
                        //*Ver password
                        onPressed: () {
                          model.obscurePassword = !model.obscurePassword;
                        },
                        icon: Icon(model.obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                      ),
                    ),
                    onChanged: (value) => model.password = value,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  MaterialButton(
                    padding: const EdgeInsets.all(16),
                    color: scheme.primaryContainer,
                    child: Text(Labels.signIn.toUpperCase()),

                    //**Confirmar que los campos no vengan vacios */
                    onPressed:
                        model.email.isNotEmpty && model.password.isNotEmpty
                            ? () async {
                                //*Si el formulario esta validado
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    await model.login();
                                    Navigator.pushNamedAndRemoveUntil(
                                        context, Root.route, (route) => false);
                                  } catch (e) {
                                    AppSnackBar(context).error(e);
                                  }
                                }
                              }
                            : null,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: Labels.sinCuenta,
                        style: styles.bodyLarge,
                        children: [
                          TextSpan(
                              text: Labels.register,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacementNamed(
                                      context, RegisterPage.route);
                                })
                        ]),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (model.loading)
          Material(
            color: scheme.surfaceVariant.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
