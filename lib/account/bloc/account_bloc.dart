import '../services/account_service.dart';
import 'account_states.dart';
import 'account_actions.dart';
import '../../general/bloc/bloc.dart';

class AccountBloc extends Bloc<AccountAction> {
  final AccountService _accountService;

  AccountBloc(this._accountService) {
    actionChannel.stream.listen((action) {
      if (action is SignUp) {
        _signUp(action);
      } else if (action is ConfirmEmail) {
        _confirmEmail(action);
      } else if (action is SignIn) {
        _signIn(action);
      } else if (action is GrantSuperuserPermissions) {
        _grantSuperuserPermissions(action);
      } else if (action is SignInAsAdmin) {
        _signInAsAdmin(action);
      }
    });
  }

  @override
  void dispose({AccountAction? cleanupAction}) {
    actionChannel.close();
  }

  void _signUp(SignUp action) async {
    // @@TODO: Validation.
    var error = await _accountService.signUp(
      action.email!,
      action.username!,
      action.password!,
    );

    action.complete(
      error == null ? AuthenticationSucceeded() : AuthenticationFailed(),
    );
  }

  void _confirmEmail(ConfirmEmail action) async {
    // @@TODO: Validation.
    var error = await _accountService.confirmEmail(
      action.email!,
      action.confirmationCode!,
    );

    action.complete(
      error == null ? AuthenticationSucceeded() : AuthenticationFailed(),
    );
  }

  void _signIn(SignIn action) async {
    // @@TODO: Validation.
    var error = await _accountService.signIn(action.email!, action.password!);
    action.complete(
      error == null ? AuthenticationSucceeded() : AuthenticationFailed(),
    );
  }

  void _grantSuperuserPermissions(GrantSuperuserPermissions action) async {
    // @@TODO: Validation.
    var error = await _accountService.grantSuperuserPermissions(
      action.payload!,
      action.signature!,
    );

    action.complete(
      error == null ? AuthenticationSucceeded() : AuthenticationFailed(),
    );
  }

  void _signInAsAdmin(SignInAsAdmin action) async {
    // @@TODO: Validation.
    var error = await _accountService.signInAsAdmin(
      action.email!,
      action.password!,
    );

    action.complete(
      error == null ? AuthenticationSucceeded() : AuthenticationFailed(),
    );
  }
}
