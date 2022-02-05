abstract class AccountState {}

abstract class AuthenticateState extends AccountState {}

class AuthenticationSucceeded extends AuthenticateState {}

class AuthenticationFailed extends AuthenticateState {}
