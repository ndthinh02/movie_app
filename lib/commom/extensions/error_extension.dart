extension ErrorMessageExtension on String? {
  String? toErrorMessage(dynamic text) {
    switch (this) {
      case "[firebase_auth/email-already-in-use] The email address is already in use by another account.":
        return text.email_is_already;
      case "[firebase_auth/invalid-email] The email address is badly formatted.":
        return text.email_invalid;
      case "[firebase_auth/invalid-credential] The supplied auth credential is incorrect, malformed or has expired.":
        return text.email_do_not_exist;
      case "[firebase_auth/weak-password] Password should be at least 6 characters":
        return text.password_week;
      default:
        return (this?.isEmpty ?? true) ? text.do_not_empty : null;
    }
  }
}
