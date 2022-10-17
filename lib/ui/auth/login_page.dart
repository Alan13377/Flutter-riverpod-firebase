import 'package:firebase_riverpod/root.dart';
import 'package:firebase_riverpod/ui/auth/providers/auth_view_model_provider.dart';
import 'package:firebase_riverpod/ui/auth/register_page.dart';
import 'package:firebase_riverpod/ui/components/loading_layer.dart';
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
    final provider = AuthViewModelProvider;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    //*Escuchamos el provider
    final model = ref.read(AuthViewModelProvider);

    return LoadingLayer(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(
                      Icons.favorite,
                      size: 80,
                      color: scheme.tertiary,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text("My App".toUpperCase(),
                        textAlign: TextAlign.center, style: styles.titleLarge),
                    SizedBox(
                      height: height / 12,
                    ),
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
                      validator: (value) =>
                          model.emailValidate(value.toString()),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Consumer(builder: ((context, ref, child) {
                      ref.watch(
                          provider.select((value) => value.obscurePassword));
                      return TextFormField(
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
                      );
                    })),
                    const SizedBox(
                      height: 24,
                    ),
                    Consumer(builder: ((context, ref, child) {
                      ref.watch(provider);
                      return MaterialButton(
                        padding: const EdgeInsets.all(16),
                        color: scheme.primaryContainer,
                        child: Text(Labels.signIn.toUpperCase()),

                        //**Confirmar que los campos no vengan vacios */
                        onPressed: model.email.isNotEmpty &&
                                model.password.isNotEmpty
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
                      );
                    })),
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
