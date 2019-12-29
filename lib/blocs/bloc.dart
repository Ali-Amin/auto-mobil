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
  BehaviorSubject<String> _fullName$ = BehaviorSubject<String>();
  BehaviorSubject<String> _phoneNumber$ = BehaviorSubject<String>();
  BehaviorSubject<String> _email$ = BehaviorSubject<String>();
  BehaviorSubject<String> _password$ = BehaviorSubject<String>();
  BehaviorSubject<String> _confirmPassword$ = BehaviorSubject<String>();
  BehaviorSubject<String> _gender$ = BehaviorSubject<String>.seeded("Mr.");

  /// `observables`
  Observable<AuthState> get authState$ => Observable(_authState$.stream);
  Observable<String> get error$ => Observable(_error$.stream);
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

  void signUp() async {
    try {
      _errorCheck();
      await _authService.signUp(
        email: _email$.value.trim().toLowerCase(),
        password: _password$.value,
      );
      FirebaseUser fbUser = await _authService.onAuthStateChanged.first;

      await _fsService.getUserDocRef(fbUser.uid).setData({
        "displayName": _fullName$.value,
        "phoneNumber": _phoneNumber$.value,
        "email": _email$.value,
        "title": _gender$.value,
        "uid": fbUser.uid,
      });
    } on PlatformException catch (e) {
      _error$.sink.add(_setErrorMessage(e.code));
      print(e.code);
    } catch (e) {
      print(e);
    }
  }

  void changeSignUpName(String name) {
    _fullName$.sink.add(name);
  }

  void changeSignUpPhoneNumber(String phoneNumber) {
    _phoneNumber$.sink.add(phoneNumber);
  }

  void changeSignUpEmail(String email) {
    _email$.sink.add(email);
  }

  void changeSignUpPassword(String password) {
    _password$.sink.add(password);
  }

  void changeSignUpConfirmPassword(String confirmPassword) {
    _confirmPassword$.sink.add(confirmPassword);
  }

  void changeGender(String gender) {
    _gender$.sink.add(gender);
  }

  void clearErrors() {
    _error$.sink.add(null);
  }

  void dispose() {
    _authState$.close();
    _error$.close();
    _fullName$.close();
    _password$.close();
    _phoneNumber$.close();
    _confirmPassword$.close();
    _email$.close();
    _gender$.close();
  }

  void _errorCheck() {
    if (_fullName$.value == "" || _fullName$.value == null)
      throw PlatformException(
        code: "EMPTY_NAME",
        message: "Please enter your full name",
      );
    if (_phoneNumber$.value == "" || _phoneNumber$.value == null)
      throw PlatformException(
        code: "EMPTY_PHONENUMBER",
        message: "Please enter your phone number",
      );
    if (_email$.value == "" || _email$.value == null)
      throw PlatformException(
        code: "EMPTY_EMAIL",
        message: "Please enter a valid email address",
      );
    if (_password$.value == "" ||
        _password$.value == null ||
        _password$.value.length < 8)
      throw PlatformException(
        code: "WEAK_PASSWORD",
        message: "Please enter a password longer than 8 characters",
      );
    if (_confirmPassword$.value == "" || _confirmPassword$.value == null)
      throw PlatformException(
        code: "EMPTY_CONFIRM_PASSWORD",
        message: "Please confirm your password",
      );
    if (_confirmPassword$.value != _password$.value)
      throw PlatformException(
        code: "PASSWORD_MISMATCH",
        message: "Your Re-entered password does not match your password",
      );
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
      case "EMPTY_NAME":
        return "Please enter your full name";
      case "EMPTY_PHONENUMBER":
        return "Please enter your phone number";
      case "EMPTY_EMAIL":
        return "Please enter a valid email address";
      case "WEAK_PASSWORD":
        return "Please enter a password longer than 8 characters";
      case "EMPTY_CONFIRM_PASSWORD":
        return "Please confirm your password";
      case "PASSWORD_MISMATCH":
        return "Your Re-entered password does not match your password";

      default:
        return "Something went wrong";
    }
  }
}

enum AuthState { Authenticated, Unauthenticated }
