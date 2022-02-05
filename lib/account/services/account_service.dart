import 'dart:math';

import '../../general/services/notification_service.dart';
import '../interfaces/iaccount_api_service.dart';
import '../../general/errors/connection_error.dart';
import '../../general/errors/server_error.dart';
import '../../general/services/server_connector.dart';
import '../../general/utils/policy.dart';
import '../../general/errors/error.dart';

class AccountService {
  final ServerConnector _serverConnector;
  final IAccountApiService _accountApiService;
  final NotificationService _notificationService;

  late final Policy _policy;

  AccountService(
    this._serverConnector,
    this._accountApiService,
    this._notificationService,
  ) {
    _policy = PolicyBuilder().on<ConnectionError>(
      strategies: [
        When(
          any,
          repeat: 1,
          withInterval: (_) => Duration(milliseconds: 200),
        ),
      ],
    ).on<ServerError>(
      strategies: [
        When(
          any,
          repeat: 3,
          withInterval: (attempt) => Duration(
            milliseconds: 200 * pow(2, attempt).toInt(),
          ),
        ),
      ],
    ).build();
  }

  Future<Error?> signUp(String email, String username, String password) async {
    try {
      await _policy.execute(
        () => _accountApiService.signUp(email, username, password),
      );

      return null;
    } catch (error) {
      _notificationService.showMessage(error.toString(), title: 'Error');
      return Error(error.toString());
    }
  }

  Future<Error?> confirmEmail(String email, String confirmationCode) async {
    try {
      await _policy.execute(
        () => _accountApiService.confirmEmail(email, confirmationCode),
      );

      _notificationService.showMessage(
        'Account confirmed successfully. You can log-in now',
      );

      return null;
    } catch (error) {
      _notificationService.showMessage(error.toString(), title: 'Error');
      return Error(error.toString());
    }
  }

  Future<Error?> signIn(String email, String password) async {
    try {
      var credentials = await _policy.execute(
        () => _accountApiService.signIn(
          'dummy',
          email,
          password,
        ),
      );

      _serverConnector.setToken(credentials.accessToken);

      return null;
    } catch (error) {
      _notificationService.showMessage(error.toString(), title: 'Error');
      return Error(error.toString());
    }
  }

  Future<Error?> grantSuperuserPermissions(
    String payload,
    String signature,
  ) async {
    try {
      await _policy.execute(
        () => _accountApiService.grantSuperuserPermissions(payload, signature),
      );

      return null;
    } catch (error) {
      _notificationService.showMessage(error.toString(), title: 'Error');
      return Error(error.toString());
    }
  }

  Future<Error?> signInAsAdmin(String email, String password) async {
    try {
      var credentials = await _policy.execute(
        () => _accountApiService.signInAsAdmin(email, password),
      );

      _serverConnector.setToken(credentials.accessToken);

      return null;
    } catch (error) {
      _notificationService.showMessage(error.toString(), title: 'Error');
      return Error(error.toString());
    }
  }
}
