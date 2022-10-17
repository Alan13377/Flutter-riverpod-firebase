import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/loading_provider.dart';

//*Provider de la clase AuthViewModel
final AuthViewModelProvider = ChangeNotifierProvider(
  (ref) => AuthViewModel(ref.read),
);

class AuthViewModel extends ChangeNotifier {
  final _reader;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthViewModel(this._reader);
  User? get user => _auth.currentUser;

  String _email = "";

  String get email => _email;

  set email(String email) {
    _email = email;
    notifyListeners();
  }

  String _password = "";

  String get password => _password;

  set password(String password) {
    _password = password;
    notifyListeners();
  }

  String _confirmPassword = "";

  String get confirmPassword => _confirmPassword;

  set confirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
    notifyListeners();
  }

  //*Pssword
  bool _obscurePassword = true;

  bool get obscurePassword => _obscurePassword;

  set obscurePassword(bool obscurePassword) {
    _obscurePassword = obscurePassword;
    notifyListeners();
  }

  bool _obscureConfirmPassword = true;

  //*Loading

  Loading get _loading => _reader(loadingProvider);

  bool get obscureConfirmPassword => _obscureConfirmPassword;

  set obscureConfirmPassword(bool obscureConfirmPassword) {
    _obscureConfirmPassword = obscureConfirmPassword;
    notifyListeners();
  }

  //*Validacion
  String? emailValidate(String value) {
    final String regex =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
    return !RegExp(regex).hasMatch(value) ? "Ingresa un email valido" : null;
  }

  //**Inicio Sesion */
  Future<void> login() async {
    _loading.start();
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _loading.end();
    } on FirebaseAuthException catch (e) {
      _loading.stop();
      if (e.code == "wrong-password") {
        return Future.error(
            "Contraseña erronea! Ingresa la Contraseña correcta.");
      } else if (e.code == "invalid-email") {
        return Future.error("Correo invalido");
      } else if (e.code == "user-not-found") {
        return Future.error("Usuario no encontrado");
      } else {
        return Future.error(e.message ?? "");
      }
    } catch (e) {
      _loading.stop();
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> register() async {
    _loading.start();
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      sendEmail();
      _loading.end();
    } on FirebaseAuthException catch (e) {
      _loading.stop();
      if (e.code == "weak-password") {
        return Future.error(
            "Contraseña demasiado debil! Ingresa una Contraseña diferente.");
      } else {
        return Future.error(e.message ?? "");
      }
    } catch (e) {
      _loading.stop();
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<void> reload() async {
    await _auth.currentUser!.reload();
  }

  Future<void> sendEmail() async {
    try {
      _auth.currentUser!.sendEmailVerification();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void streamCheck({required VoidCallback onDone}) {
    final stream = Stream.periodic(const Duration(seconds: 2), (t) => t);
    stream.listen((event) async {
      await reload();
      if (_auth.currentUser!.emailVerified) {
        onDone();
      }
    });
  }
}
