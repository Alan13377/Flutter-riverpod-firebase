import 'package:firebase_riverpod/root.dart';
import 'package:firebase_riverpod/ui/auth/providers/auth_view_model_provider copy.dart';
import 'package:firebase_riverpod/ui/components/snackbar.dart';
import 'package:firebase_riverpod/ui/utils/labels.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterPage extends ConsumerWidget {
  static const String route = "/register";
  final _formKey = GlobalKey<FormState>();
  RegisterPage({super.key});

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
                    Labels.signUp,
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

                  //**PASSWORD */
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
                    height: 16,
                  ),

                  //**PASSWORD */
                  TextFormField(
                    obscureText: model.obscureConfirmPassword,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_clock_outlined),
                      label: Text(Labels.confirmPassword),
                      suffixIcon: IconButton(
                        //*Ver password
                        onPressed: () {
                          model.obscureConfirmPassword =
                              !model.obscureConfirmPassword;
                        },
                        icon: Icon(model.obscureConfirmPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                      ),
                    ),
                    onChanged: (value) => model.confirmPassword = value,
                    validator: (value) => value != model.password
                        ? "No coinciden las contraseñas"
                        : null,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  MaterialButton(
                    padding: const EdgeInsets.all(16),
                    color: scheme.primaryContainer,
                    child: Text(Labels.signUp.toUpperCase()),

                    //**Confirmar que los campos no vengan vacios */
                    onPressed: model.email.isNotEmpty &&
                            model.password.isNotEmpty &&
                            model.confirmPassword.isNotEmpty
                        ? () async {
                            //*Si el formulario esta validado
                            if (_formKey.currentState!.validate()) {
                              try {
                                await model.register();
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
                        text: Labels.conCuenta,
                        style: styles.bodyLarge,
                        children: [
                          TextSpan(
                              text: Labels.signIn,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacementNamed(
                                      context, Root.route);
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
