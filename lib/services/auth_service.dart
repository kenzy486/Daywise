import 'package:firebase_auth/firebase_auth.dart';

import '../l10n/app_localizations.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp(String email, String password) =>
      _auth.createUserWithEmailAndPassword(email: email.trim(), password: password);

  Future<void> logIn(String email, String password) =>
      _auth.signInWithEmailAndPassword(email: email.trim(), password: password);

  /// [languageCode] makes Firebase send the reset email in Arabic or English.
  Future<void> sendPasswordReset(String email, String languageCode) async {
    await _auth.setLanguageCode(languageCode);
    await _auth.sendPasswordResetEmail(email: email.trim());
  }

  Future<void> logOut() => _auth.signOut();
}

/// Turns a Firebase error into a friendly message in the current language.
String authErrorMessage(Object error, AppLocalizations t) {
  if (error is FirebaseAuthException) {
    switch (error.code) {
      case 'invalid-email':
        return t.errInvalidEmail;
      case 'weak-password':
        return t.errWeakPassword;
      case 'email-already-in-use':
        return t.errEmailInUse;
      case 'invalid-credential':
      case 'wrong-password':
      case 'user-not-found':
        return t.errWrongCredentials;
      case 'too-many-requests':
        return t.errTooManyRequests;
      case 'network-request-failed':
        return t.errNetwork;
    }
  }
  return t.errUnknown;
}
