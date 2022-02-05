class SignInRequestDto {
  final String deviceId;
  final String email;
  final String password;

  SignInRequestDto({
    required this.deviceId,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};

    map['deviceId'] = deviceId;
    map['email'] = email;
    map['password'] = password;

    return map;
  }
}
