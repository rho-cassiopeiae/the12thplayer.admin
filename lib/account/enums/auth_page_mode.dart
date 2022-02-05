enum AuthPageMode {
  SignUp,
  SignIn,
  Confirm,
  SignInAsAdmin,
  Superuser,
}

extension AuthPageModeExtension on AuthPageMode {
  String get name {
    switch (this) {
      case AuthPageMode.SignUp:
        return 'Sign-up';
      case AuthPageMode.SignIn:
        return 'Sign-in';
      case AuthPageMode.Confirm:
        return 'Confirm email';
      case AuthPageMode.SignInAsAdmin:
        return 'Sign-in as admin';
      case AuthPageMode.Superuser:
        return 'Grant superuser privileges';
    }
  }
}
