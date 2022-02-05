class SecurityCredentialsDto {
  final String? username;
  final String accessToken;

  SecurityCredentialsDto.fromJson(Map<String, dynamic> map)
      : username = map.containsKey('username') ? map['username'] : null,
        accessToken = map['accessToken'];
}
