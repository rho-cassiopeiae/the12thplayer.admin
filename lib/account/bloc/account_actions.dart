import 'account_states.dart';
import '../../general/bloc/mixins.dart';

abstract class AccountAction {}

abstract class AccountActionAwaitable<T extends AccountState>
    extends AccountAction with AwaitableState<T> {}

class SignUp extends AccountActionAwaitable<AuthenticateState> {
  final String? email;
  final String? username;
  final String? password;

  SignUp({
    required this.email,
    required this.username,
    required this.password,
  });
}

class ConfirmEmail extends AccountActionAwaitable<AuthenticateState> {
  final String? email;
  final String? confirmationCode;

  ConfirmEmail({
    required this.email,
    required this.confirmationCode,
  });
}

class SignIn extends AccountActionAwaitable<AuthenticateState> {
  final String? email;
  final String? password;

  SignIn({
    required this.email,
    required this.password,
  });
}

class GrantSuperuserPermissions
    extends AccountActionAwaitable<AuthenticateState> {
  final String? payload;
  final String? signature;

  GrantSuperuserPermissions({
    required this.payload,
    required this.signature,
  });
}

class SignInAsAdmin extends AccountActionAwaitable<AuthenticateState> {
  final String? email;
  final String? password;

  SignInAsAdmin({
    required this.email,
    required this.password,
  });
}
