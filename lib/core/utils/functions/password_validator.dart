class PasswordValidation {
  final bool hasMinLength;
  final bool hasUppercase;
  final bool hasLowercase;
  final bool hasSpecialChar;
  final bool hasNumber;

  const PasswordValidation({
    required this.hasMinLength,
    required this.hasUppercase,
    required this.hasLowercase,
    required this.hasSpecialChar,
    required this.hasNumber,
  });

  int get score => [
        hasMinLength,
        hasUppercase,
        hasLowercase,
        hasSpecialChar,
        hasNumber,
      ].where((e) => e).length;

  bool get isValid =>
      hasMinLength &&
      hasUppercase &&
      hasLowercase &&
      hasSpecialChar &&
      hasNumber;
}

PasswordValidation validatePassword(String password) {
  return PasswordValidation(
    hasMinLength: password.length >= 8,
    hasUppercase: RegExp(r'[A-Z]').hasMatch(password),
    hasLowercase: RegExp(r'[a-z]').hasMatch(password),
    hasSpecialChar: RegExp(r'[@&_]').hasMatch(password),
    hasNumber: RegExp(r'[0-9]').hasMatch(password),
  );
}

String getPasswordHint(PasswordValidation v) {
  if (!v.hasMinLength) {
    return "Add at least 8 characters";
  }

  if (!v.hasUppercase) {
    return "Add an uppercase letter";
  }

  if (!v.hasLowercase) {
    return "Add a lowercase letter";
  }

  if (!v.hasNumber) {
    return "Add a number";
  }

  if (!v.hasSpecialChar) {
    return "Add @, &, or _";
  }

  return "Password is strong";
}
