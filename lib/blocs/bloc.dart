import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:grad/models/brand.dart';
import 'package:grad/services/firebase_auth.dart';
import 'package:grad/services/firestore.dart';
import 'package:rxdart/rxdart.dart';

class Bloc {
  final AuthService _authService = AuthService();
  final FirestoreAPI _fsService = FirestoreAPI();

  /// `subjects`
  BehaviorSubject<AuthState> _authState$ =
      BehaviorSubject<AuthState>.seeded(AuthState.Unauthenticated);
  BehaviorSubject<String> _error$ = BehaviorSubject<String>();

  /// `observables`
  Observable<AuthState> get authState$ => Observable(_authState$.stream);

  Observable<List<Brand>> get brands$ => Observable(
        _fsService.brands$.map(
          (query) =>
              query.documents.map((doc) => Brand.fromJson(doc.data)).toList(),
        ),
      );

  Bloc() {
    _authService.onAuthStateChanged.listen(
      (FirebaseUser user) {
        if (user == null) {
          _authState$.sink.add(AuthState.Unauthenticated);
        } else {
          _authState$.sink.add(AuthState.Authenticated);
        }
      },
    );
  }

  /// `methods`
  void signIn({@required String email, @required String password}) async {
    try {
      AuthResult result = await _authService.signInWithEmailAndPass(
        email: email.trim(),
        password: password,
      );

      if (result.user != null) {
        _authState$.sink.add(AuthState.Authenticated);
      }
    } on PlatformException catch (e) {
      _error$.sink.add(_setErrorMessage(e.code));
      print(e.code);
    } catch (e) {
      print(e);
    }
  }

  void signUp({@required String email, @required String password}) async {
    try {
      await _authService.signUp(email: email.trim(), password: password);
    } on PlatformException catch (e) {
      _error$.sink.add(_setErrorMessage(e.code));
      print(e.code);
    } catch (e) {
      print(e);
    }
  }

  void dispose() {
    _authState$.close();
    _error$.close();
  }

  String _setErrorMessage(String errorCode) {
    switch (errorCode) {
      case "ERROR_INVALID_EMAIL":
        return "Invalid email format";
      case "ERROR_WRONG_PASSWORD":
        return "Incorrect password";
      case "ERROR_USER_DISABLED":
        return "This user has been blocked, please contact customer support";
      case "ERROR_TOO_MANY_REQUESTS":
        return "Too many attempts to sign in, please try again later";
      case "ERROR_USER_NOT_FOUND":
        return "You need to sign up first";
      case "ERROR_OPERATION_NOT_ALLOWED":
        return "Something went wrong";
      case "ERROR_WEAK_PASSWORD":
        return "Password is weak, please enter a stronger password";
      case "ERROR_EMAIL_ALREADY_IN_USE":
        return "An account is already linked to this email";
      default:
        return "Somethign went wrong";
    }
  }
}

enum AuthState { Authenticated, Unauthenticated }
