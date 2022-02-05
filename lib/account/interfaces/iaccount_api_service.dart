import '../models/dto/security_credentials_dto.dart';

abstract class IAccountApiService {
  Future signUp(String email, String username, String password);

  Future confirmEmail(String email, String confirmationCode);

  Future<SecurityCredentialsDto> signIn(
    String deviceId,
    String email,
    String password,
  );

  Future grantSuperuserPermissions(String payload, String signature);

  Future<SecurityCredentialsDto> signInAsAdmin(String email, String password);
}
