import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final _fbAuth = FirebaseAuth.instance;
  Stream<FirebaseUser> get onAuthStateChanged => _fbAuth.onAuthStateChanged;
  Future<void> sendSmsCode({
    @required String phoneNumber,
    @required Function(String) codeAutoRetrievalTimeout,
    @required Function(String, [int]) codeSent,
    @required Duration timeout,
    @required Function(AuthCredential) verificationCompleted,
    @required Function(AuthException) verificationFailed,
    @required int forceResendingToken,
  }) {
    return _fbAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        codeSent: codeSent,
        timeout: timeout,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        forceResendingToken: forceResendingToken);
  }

  Future<AuthResult> verifySmsCode({
    @required String smsCode,
    @required String verificationId,
  }) {
    AuthCredential credential = PhoneAuthProvider.getCredential(
        smsCode: smsCode, verificationId: verificationId);
    Future<AuthResult> result = _fbAuth.signInWithCredential(credential);
    return result;
  }

  Future<AuthResult> signInWithEmailAndPass(
      {@required String email, @required String password}) {
    return _fbAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signUp({@required String email, @required String password}) {
    return _fbAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
