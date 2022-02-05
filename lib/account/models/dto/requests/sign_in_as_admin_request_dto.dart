class SignInAsAdminRequestDto {
  final String email;
  final String password;

  SignInAsAdminRequestDto({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};

    map['email'] = email;
    map['password'] = password;

    return map;
  }
}
