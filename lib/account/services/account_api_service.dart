import 'package:dio/dio.dart';

import '../models/dto/requests/grant_superuser_permissions_request_dto.dart';
import '../models/dto/requests/sign_in_as_admin_request_dto.dart';
import '../models/dto/security_credentials_dto.dart';
import '../../general/errors/authentication_token_expired_error.dart';
import '../../general/errors/forbidden_error.dart';
import '../../general/errors/invalid_authentication_token_error.dart';
import '../../general/services/server_connector.dart';
import '../errors/account_error.dart';
import '../../general/errors/api_error.dart';
import '../../general/errors/connection_error.dart';
import '../../general/errors/server_error.dart';
import '../../general/errors/validation_error.dart';
import '../interfaces/iaccount_api_service.dart';
import '../models/dto/requests/confirm_email_request_dto.dart';
import '../models/dto/requests/sign_in_request_dto.dart';
import '../models/dto/requests/sign_up_request_dto.dart';

class AccountApiService implements IAccountApiService {
  final ServerConnector _serverConnector;

  Dio get _dioIdentity => _serverConnector.dioIdentity;
  Dio get _dioAdmin => _serverConnector.dioAdmin;

  AccountApiService(this._serverConnector);

  dynamic _wrapError(DioError dioError) {
    // ignore: missing_enum_constant_in_switch
    switch (dioError.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        return ConnectionError();
      case DioErrorType.response:
        var response = dioError.response!;
        var statusCode = response.statusCode!;
        if (statusCode >= 500) {
          return ServerError();
        }

        switch (statusCode) {
          case 400:
            var error = response.data['error'];
            if (error['type'] == 'Validation') {
              return ValidationError();
            } else if (error['type'] == 'Account') {
              return AccountError(error['errors'].values.first.first);
            }
            break; // @@NOTE: Should never actually reach here.
          case 401:
            var errorMessage =
                response.data['error']['errors'].values.first.first;
            if (errorMessage.contains('token expired at')) {
              return AuthenticationTokenExpiredError();
            }
            return InvalidAuthenticationTokenError(errorMessage);
          case 403:
            return ForbiddenError();
        }
    }

    print(dioError);

    return ApiError();
  }

  @override
  Future signUp(String email, String username, String password) async {
    try {
      await _dioIdentity.post(
        '/identity/account/sign-up',
        data: SignUpRequestDto(
          email: email,
          username: username,
          password: password,
        ).toJson(),
      );
    } on DioError catch (error) {
      throw _wrapError(error);
    }
  }

  @override
  Future confirmEmail(String email, String confirmationCode) async {
    try {
      await _dioIdentity.post(
        '/identity/account/confirm-email',
        data: ConfirmEmailRequestDto(
          email: email,
          confirmationCode: confirmationCode,
        ).toJson(),
      );
    } on DioError catch (error) {
      throw _wrapError(error);
    }
  }

  @override
  Future<SecurityCredentialsDto> signIn(
    String deviceId,
    String email,
    String password,
  ) async {
    try {
      var response = await _dioIdentity.post(
        '/identity/account/sign-in',
        data: SignInRequestDto(
          deviceId: deviceId,
          email: email,
          password: password,
        ).toJson(),
      );

      return SecurityCredentialsDto.fromJson(response.data['data']);
    } on DioError catch (error) {
      throw _wrapError(error);
    }
  }

  @override
  Future grantSuperuserPermissions(String payload, String signature) async {
    try {
      await _dioAdmin.put(
        '/admin/profiles/superuser',
        data: GrantSuperuserPermissionsRequestDto(
          payload: payload,
          signature: signature,
        ).toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer ${_serverConnector.accessToken}',
          },
        ),
      );
    } on DioError catch (error) {
      throw _wrapError(error);
    }
  }

  @override
  Future<SecurityCredentialsDto> signInAsAdmin(
    String email,
    String password,
  ) async {
    try {
      var response = await _dioAdmin.post(
        '/admin/log-in',
        data: SignInAsAdminRequestDto(
          email: email,
          password: password,
        ).toJson(),
      );

      return SecurityCredentialsDto.fromJson(response.data['data']);
    } on DioError catch (error) {
      throw _wrapError(error);
    }
  }
}
